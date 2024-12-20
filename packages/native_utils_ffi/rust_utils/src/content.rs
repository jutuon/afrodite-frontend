

//! Encrypt and decrypt content files.

use aes_gcm::{aead::{generic_array::GenericArray, AeadMutInPlace, OsRng}, AeadCore, Aes256Gcm, Key, KeyInit, Nonce};

use crate::buffer::SliceBuffer;

#[derive(Debug, Clone, Copy, PartialEq)]
#[repr(u8)]
pub enum ContentEncryptionError {
    EmptyPlaintextData = 1,
    EncryptionError = 2,
    DecryptionError = 3,
    UnexpectedNonceSize = 4,
    InvalidKeyBufferSize = 5,
    BufferInitFailed = 6,
}

/// Nonce size in bytes for 96-bit nonce.
const NONCE_SIZE_IN_BYTES: usize = 12;
const AUTHENTICATION_TAG_SIZE_IN_BYTES: usize = 16;

/// Generate a new content encryption key.
///
/// The buffer for key generation must be 32 bytes long.
///
/// The buffer can contain random data as it will be overwritten.
pub fn generate_content_encryption_key(key_output: &mut [u8]) -> Result<(), ContentEncryptionError> {
    generate_content_encryption_key_with_key_provider(
        key_output,
        || Aes256Gcm::generate_key(OsRng),
    )
}

fn generate_content_encryption_key_with_key_provider(
    key_output: &mut [u8],
    key_provider: impl FnOnce() -> Key<Aes256Gcm>,
) -> Result<(), ContentEncryptionError> {
    let key = key_provider();
    if key_output.len() != key.len() {
        return Err(ContentEncryptionError::InvalidKeyBufferSize);
    }

    key_output.copy_from_slice(key.as_ref());

    Ok(())
}

/// Replace plaintext with chiphertext and nonce.
///
/// The buffer needs to have 28 bytes empty space at the end.
///
/// The buffer can contain random data as it will be overwritten.
pub fn encrypt_content(data: &mut [u8], key: &[u8]) -> Result<(), ContentEncryptionError> {
    encrypt_content_with_nonce_provider(
        data,
        key,
        || Aes256Gcm::generate_nonce(OsRng)
    )
}

fn encrypt_content_with_nonce_provider(
    data: &mut [u8],
    key: &[u8],
    nonce_provider: impl FnOnce() -> Nonce<<Aes256Gcm as AeadCore>::NonceSize>,
) -> Result<(), ContentEncryptionError> {
    let empty_space_size = AUTHENTICATION_TAG_SIZE_IN_BYTES + NONCE_SIZE_IN_BYTES;
    if data.len() <= empty_space_size {
        return Err(ContentEncryptionError::EmptyPlaintextData);
    }

    let (working_area, nonce_area) = data.split_at_mut(data.len() - NONCE_SIZE_IN_BYTES);

    let mut buf = SliceBuffer::buffer_with_empty_space(working_area, AUTHENTICATION_TAG_SIZE_IN_BYTES)
        .map_err(|_| ContentEncryptionError::BufferInitFailed)?;

    let mut chipher = Aes256Gcm::new_from_slice(key)
        .map_err(|_| ContentEncryptionError::InvalidKeyBufferSize)?;

    let nonce = nonce_provider();
    if nonce_area.len() != nonce.len() {
        return Err(ContentEncryptionError::UnexpectedNonceSize);
    }

    chipher.encrypt_in_place(&nonce, &[], &mut buf)
        .map_err(|_| ContentEncryptionError::EncryptionError)?;
    nonce_area.copy_from_slice(nonce.as_ref());

    Ok(())
}

/// Replace chiphertext and nonce with plaintext data.
///
/// The plaintext data is 28 bytes shorter than the buffer size.
pub fn decrypt_content(data: &mut [u8], key: &[u8]) -> Result<(), ContentEncryptionError> {
    let encryption_related_extra_data_size = NONCE_SIZE_IN_BYTES + AUTHENTICATION_TAG_SIZE_IN_BYTES;
    if data.len() <= encryption_related_extra_data_size {
        return Err(ContentEncryptionError::EmptyPlaintextData);
    }

    let (chiphertext, nonce) = data.split_at_mut(data.len() - NONCE_SIZE_IN_BYTES);

    let nonce: [u8; NONCE_SIZE_IN_BYTES] = nonce.try_into()
        .map_err(|_| ContentEncryptionError::UnexpectedNonceSize)?;
    let nonce = GenericArray::from(nonce);

    let mut buf = SliceBuffer::buffer_with_empty_space(chiphertext, 0)
        .map_err(|_| ContentEncryptionError::BufferInitFailed)?;

    let mut chipher = Aes256Gcm::new_from_slice(key)
        .map_err(|_| ContentEncryptionError::InvalidKeyBufferSize)?;
    chipher.decrypt_in_place(&nonce, &[], &mut buf)
        .map_err(|_| ContentEncryptionError::DecryptionError)?;

    Ok(())
}

#[cfg(test)]
mod test {
    use super::*;

    const KEY_SIZE: usize = 32;
    #[test]
    fn test_generate_content_encryption_key() {
        let mut key_buffer = [0u8; KEY_SIZE];
        let wanted_key = [1u8; KEY_SIZE];

        assert_ne!(key_buffer, wanted_key);
        assert_eq!(
            generate_content_encryption_key_with_key_provider(&mut key_buffer, || wanted_key.into()),
            Ok(())
        );
        assert_eq!(key_buffer, wanted_key);
    }

    #[test]
    fn test_encrypt_and_decrypt() {
        let key = [0u8; KEY_SIZE];

        let initial_data: u8 = 0b10101010;
        let mut data = [initial_data; NONCE_SIZE_IN_BYTES + AUTHENTICATION_TAG_SIZE_IN_BYTES + 1];

        assert_eq!(
            encrypt_content_with_nonce_provider(&mut data, &key, || [0u8; NONCE_SIZE_IN_BYTES].into()),
            Ok(())
        );

        // Nonce part of the data should be empty
        for d in data.iter().rev().take(NONCE_SIZE_IN_BYTES) {
            assert_eq!(*d, 0);
        }

        // Rest of the buffer changed
        for d in data.iter().rev().skip(NONCE_SIZE_IN_BYTES) {
            assert_ne!(*d, initial_data);
        }

        assert_eq!(decrypt_content(&mut data, &key), Ok(()));

        // Data is plaintext again
        assert_eq!(data[0], initial_data);

        // Rest of the nonce still exists
        for d in data.iter().rev().take(NONCE_SIZE_IN_BYTES) {
            assert_eq!(*d, 0);
        }
    }
}
