import 'package:global_services/core/network/network.dart';
import 'package:global_services/features/home/repository/base_home_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BaseHomeRepository)
class HomeRepository implements BaseHomeRepository {
  final DioHelper network;
  const HomeRepository(this.network);
}
