//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CommonAdminApi {
  CommonAdminApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get dynamic backend config.
  ///
  /// # Permissions Requires admin_server_maintenance_view_backend_settings.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getBackendConfigWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/backend_config';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get dynamic backend config.
  ///
  /// # Permissions Requires admin_server_maintenance_view_backend_settings.
  Future<BackendConfig?> getBackendConfig() async {
    final response = await getBackendConfigWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'BackendConfig',) as BackendConfig;
    
    }
    return null;
  }

  /// Get available manager instances.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_view_info] * Permission [model::Permissions::admin_server_maintenance_update_software] * Permission [model::Permissions::admin_server_maintenance_reset_data] * Permission [model::Permissions::admin_server_maintenance_reboot_backend]
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getManagerInstanceNamesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/manager_instance_names';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get available manager instances.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_view_info] * Permission [model::Permissions::admin_server_maintenance_update_software] * Permission [model::Permissions::admin_server_maintenance_reset_data] * Permission [model::Permissions::admin_server_maintenance_reboot_backend]
  Future<ManagerInstanceNameList?> getManagerInstanceNames() async {
    final response = await getManagerInstanceNamesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ManagerInstanceNameList',) as ManagerInstanceNameList;
    
    }
    return null;
  }

  /// Get performance data
  ///
  /// # Permissions Requires admin_server_maintenance_view_info.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UnixTime] startTime:
  ///   Start time for query results.
  ///
  /// * [GetPerfDataEndTimeParameter] endTime:
  ///   End time for query results.
  Future<Response> getPerfDataWithHttpInfo({ UnixTime? startTime, GetPerfDataEndTimeParameter? endTime, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/perf_data';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (startTime != null) {
      queryParams.addAll(_queryParams('', 'start_time', startTime));
    }
    if (endTime != null) {
      queryParams.addAll(_queryParams('', 'end_time', endTime));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get performance data
  ///
  /// # Permissions Requires admin_server_maintenance_view_info.
  ///
  /// Parameters:
  ///
  /// * [UnixTime] startTime:
  ///   Start time for query results.
  ///
  /// * [GetPerfDataEndTimeParameter] endTime:
  ///   End time for query results.
  Future<PerfMetricQueryResult?> getPerfData({ UnixTime? startTime, GetPerfDataEndTimeParameter? endTime, }) async {
    final response = await getPerfDataWithHttpInfo( startTime: startTime, endTime: endTime, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PerfMetricQueryResult',) as PerfMetricQueryResult;
    
    }
    return null;
  }

  /// Get scheduled tasks status from manager instance.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_reboot_backend]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<Response> getScheduledTasksStatusWithHttpInfo(String managerName,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/scheduled_tasks_status';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get scheduled tasks status from manager instance.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_reboot_backend]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<ScheduledTaskStatus?> getScheduledTasksStatus(String managerName,) async {
    final response = await getScheduledTasksStatusWithHttpInfo(managerName,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ScheduledTaskStatus',) as ScheduledTaskStatus;
    
    }
    return null;
  }

  /// Get software version information from manager instance.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_view_info]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<Response> getSoftwareUpdateStatusWithHttpInfo(String managerName,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/software_info';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get software version information from manager instance.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_view_info]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<SoftwareUpdateStatus?> getSoftwareUpdateStatus(String managerName,) async {
    final response = await getSoftwareUpdateStatusWithHttpInfo(managerName,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SoftwareUpdateStatus',) as SoftwareUpdateStatus;
    
    }
    return null;
  }

  /// Get system information from manager instance.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_view_info]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<Response> getSystemInfoWithHttpInfo(String managerName,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/system_info';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get system information from manager instance.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_view_info]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<SystemInfo?> getSystemInfo(String managerName,) async {
    final response = await getSystemInfoWithHttpInfo(managerName,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SystemInfo',) as SystemInfo;
    
    }
    return null;
  }

  /// Save dynamic backend config.
  ///
  /// # Permissions Requires admin_server_maintenance_save_backend_settings.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [BackendConfig] backendConfig (required):
  Future<Response> postBackendConfigWithHttpInfo(BackendConfig backendConfig,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/backend_config';

    // ignore: prefer_final_locals
    Object? postBody = backendConfig;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Save dynamic backend config.
  ///
  /// # Permissions Requires admin_server_maintenance_save_backend_settings.
  ///
  /// Parameters:
  ///
  /// * [BackendConfig] backendConfig (required):
  Future<void> postBackendConfig(BackendConfig backendConfig,) async {
    final response = await postBackendConfigWithHttpInfo(backendConfig,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Schedule task.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_reboot_backend]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  ///
  /// * [ScheduledTaskType] scheduledTaskType (required):
  ///
  /// * [bool] notifyBackend (required):
  Future<Response> postScheduleTaskWithHttpInfo(String managerName, ScheduledTaskType scheduledTaskType, bool notifyBackend,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/schedule_task';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));
      queryParams.addAll(_queryParams('', 'scheduled_task_type', scheduledTaskType));
      queryParams.addAll(_queryParams('', 'notify_backend', notifyBackend));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Schedule task.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_reboot_backend]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  ///
  /// * [ScheduledTaskType] scheduledTaskType (required):
  ///
  /// * [bool] notifyBackend (required):
  Future<void> postScheduleTask(String managerName, ScheduledTaskType scheduledTaskType, bool notifyBackend,) async {
    final response = await postScheduleTaskWithHttpInfo(managerName, scheduledTaskType, notifyBackend,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Trigger backend data reset which also restarts the backend.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_reset_data]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<Response> postTriggerBackendDataResetWithHttpInfo(String managerName,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/trigger_backend_data_reset';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Trigger backend data reset which also restarts the backend.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_reset_data]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<void> postTriggerBackendDataReset(String managerName,) async {
    final response = await postTriggerBackendDataResetWithHttpInfo(managerName,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Trigger backend restart.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_reboot_backend]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<Response> postTriggerBackendRestartWithHttpInfo(String managerName,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/trigger_backend_restart';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Trigger backend restart.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_reboot_backend]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<void> postTriggerBackendRestart(String managerName,) async {
    final response = await postTriggerBackendRestartWithHttpInfo(managerName,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Trigger software update download.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_update_software]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<Response> postTriggerSoftwareUpdateDownloadWithHttpInfo(String managerName,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/trigger_software_update_download';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Trigger software update download.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_update_software]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<void> postTriggerSoftwareUpdateDownload(String managerName,) async {
    final response = await postTriggerSoftwareUpdateDownloadWithHttpInfo(managerName,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Trigger software update install.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_update_software]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  ///
  /// * [String] name (required):
  ///
  /// * [String] sha256 (required):
  Future<Response> postTriggerSoftwareUpdateInstallWithHttpInfo(String managerName, String name, String sha256,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/trigger_software_update_install';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));
      queryParams.addAll(_queryParams('', 'name', name));
      queryParams.addAll(_queryParams('', 'sha256', sha256));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Trigger software update install.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_update_software]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  ///
  /// * [String] name (required):
  ///
  /// * [String] sha256 (required):
  Future<void> postTriggerSoftwareUpdateInstall(String managerName, String name, String sha256,) async {
    final response = await postTriggerSoftwareUpdateInstallWithHttpInfo(managerName, name, sha256,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Trigger system reboot.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_reboot_backend]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<Response> postTriggerSystemRebootWithHttpInfo(String managerName,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/trigger_system_reboot';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Trigger system reboot.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_reboot_backend]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<void> postTriggerSystemReboot(String managerName,) async {
    final response = await postTriggerSystemRebootWithHttpInfo(managerName,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Unschedule task.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_reboot_backend]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  ///
  /// * [ScheduledTaskType] scheduledTaskType (required):
  Future<Response> postUnscheduleTaskWithHttpInfo(String managerName, ScheduledTaskType scheduledTaskType,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/unschedule_task';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));
      queryParams.addAll(_queryParams('', 'scheduled_task_type', scheduledTaskType));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Unschedule task.
  ///
  /// # Access * Permission [model::Permissions::admin_server_maintenance_reboot_backend]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  ///
  /// * [ScheduledTaskType] scheduledTaskType (required):
  Future<void> postUnscheduleTask(String managerName, ScheduledTaskType scheduledTaskType,) async {
    final response = await postUnscheduleTaskWithHttpInfo(managerName, scheduledTaskType,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
