import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BusScheduleScreen extends StatelessWidget {
  final String ilce;

  const BusScheduleScreen(this.ilce, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$ilce Otobüs Seferleri'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection(ilce).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Veriler alınırken bir hata oluştu.'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Veri bulunamadı.'));
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data?.docs[index].data() as Map<String, dynamic>;
              return _buildSongListItem(data['saat']);
            },
          );
        },
      ),
    );
  }
  

Widget _buildSongListItem(String time) {
  bool hasDeparted = DateTime.now().hour > int.parse(time.split(':')[0]);
  Color statusColor = hasDeparted ? Colors.red : Colors.green;
  String statusText = hasDeparted ? 'Kalktı' : 'Kalkmadı';

  return Card(
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: ListTile(
      leading: const Icon(Icons.directions_bus),
      title: Text(time),
      subtitle: Text(
        statusText,
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.bold,
        ),
      ),
     // trailing: const Icon(Icons.more_vert),
      onTap: () {
        // Saate tıklandığında yapılacak işlemler
      },
    ),
  );
}

}