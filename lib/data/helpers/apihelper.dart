import 'package:supabase_flutter/supabase_flutter.dart';

class ApiHelper {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getDesireMoviesByCityandSchedule(String movieStatus, String cityName) async {
    final response = await _client
      .from('movie')
      .select('''
        m_title, 
        m_genre,
        schedule (
          sch_status,
          studio (
            cinema (
              city (
                city_id,
                c_name
              )
            )
          )
        )
      ''')
      .eq('schedule.sch_status', true)
      .eq('m_status', movieStatus)
      .eq('schedule.studio.cinema.city.c_name', cityName)
      .execute();

    if (response.status == 200) {
      return List<Map<String, dynamic>>.from(response.data as List);
    } else {
      throw Exception('Error fetching movies: ${response.status} - ${response.data}');
    }
  }

  Future<List<Map<String, dynamic>>> getListofLocation() async {
    final response = await _client
      .from('city')
      .select('c_name')
      .execute();

    if (response.status == 200) {
      return List<Map<String, dynamic>>.from(response.data as List);
    } else {
      throw Exception('Error fetching location: ${response.status} - ${response.data}');
    }
  }

}
