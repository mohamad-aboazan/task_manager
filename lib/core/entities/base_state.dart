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
