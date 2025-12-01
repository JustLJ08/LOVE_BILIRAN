import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

import 'core/utils/image_helper.dart';
import 'core/utils/url_launcher_helper.dart';
import 'data/datasources/remote/cloudinary_service.dart';
import 'data/datasources/remote/firebase_auth_service.dart';
import 'data/datasources/remote/firestore_service.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/data_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/data_repository.dart';
import 'domain/usecases/auth/get_current_user_usecase.dart';
import 'domain/usecases/auth/sign_in_usecase.dart';
import 'domain/usecases/auth/sign_out_usecase.dart';
import 'domain/usecases/data/add_announcement_usecase.dart';
import 'domain/usecases/data/add_contact_usecase.dart';
import 'domain/usecases/data/add_event_usecase.dart';
import 'domain/usecases/data/add_spot_usecase.dart';
import 'domain/usecases/data/get_announcements_usecase.dart';
import 'domain/usecases/data/get_contacts_usecase.dart';
import 'domain/usecases/data/get_events_usecase.dart';
import 'domain/usecases/data/get_spots_usecase.dart';
import 'domain/usecases/data/upload_image_usecase.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/data/data_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ! Features - Auth
  // Bloc
  sl.registerFactory(() => AuthBloc(
        signIn: sl(),
        signOut: sl(),
        getCurrentUser: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthServiceImpl(auth: sl()),
  );

  // ! Features - Data (Spots, Events, etc.)
  // Bloc
  sl.registerFactory(() => DataBloc(
        getSpots: sl(),
        getEvents: sl(),
        getAnnouncements: sl(),
        getContacts: sl(),
        addSpot: sl(),
        addEvent: sl(),
        addAnnouncement: sl(),
        addContact: sl(),
        uploadImage: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetSpotsUseCase(sl()));
  sl.registerLazySingleton(() => GetEventsUseCase(sl()));
  sl.registerLazySingleton(() => GetAnnouncementsUseCase(sl()));
  sl.registerLazySingleton(() => GetContactsUseCase(sl()));
  sl.registerLazySingleton(() => AddSpotUseCase(sl()));
  sl.registerLazySingleton(() => AddEventUseCase(sl()));
  sl.registerLazySingleton(() => AddAnnouncementUseCase(sl()));
  sl.registerLazySingleton(() => AddContactUseCase(sl()));
  sl.registerLazySingleton(() => UploadImageUseCase(sl()));

  // Repository
  sl.registerLazySingleton<DataRepository>(
    () => DataRepositoryImpl(
      firestoreService: sl(),
      cloudinaryService: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<FirestoreService>(
    () => FirestoreServiceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<CloudinaryService>(
    () => CloudinaryServiceImpl(cloudinary: sl()),
  );

  // ! Core
  sl.registerLazySingleton(() => ImageHelper());
  sl.registerLazySingleton(() => UrlLauncherHelper());

  // ! External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  // Replace with your actual Cloudinary credentials
  sl.registerLazySingleton(() => CloudinaryPublic('dcqlmbxbi', 'love_biliran', cache: false));
}