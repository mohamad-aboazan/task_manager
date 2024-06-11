
///======================================================================================================
/// Represents the response from an operation, encapsulating its result, status, and error message.
/// 
/// This generic class provides a consistent structure for handling different states of an operation,
/// including success, loading, and error.
/// 
/// The [BaseResponse] class contains three main properties:
/// - [data]: Represents the resulting data from the operation.
/// - [status]: Indicates the status of the operation, such as success, loading, or error.
/// - [error]: Contains an optional error message in case of failure.
/// 
/// It also provides several constructors for convenience:
/// - [BaseResponse]: Initializes a [BaseResponse] instance with the provided data, status, and error message.
/// - [BaseResponse.success]: Creates a [BaseResponse] instance with a successful status and provided data.
/// - [BaseResponse.loading]: Creates a [BaseResponse] instance with a loading status.
/// - [BaseResponse.error]: Creates a [BaseResponse] instance with an error status and provided error message.
///======================================================================================================

class BaseResponse<T> {
  T? data;
  Status? status;
  String? error;

  BaseResponse({this.data, this.error, this.status});

  BaseResponse.success(T this.data) {
    this.status = Status.success;
  }

  BaseResponse.loading() {
    this.status = Status.loading;
  }
  BaseResponse.error(String this.error) {
    this.status = Status.error;
  }
}

enum Status { success, loading, error, init }
