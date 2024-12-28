import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:yoga_app/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  String _selectedLevel = 'Débutant';
  bool _isEditing = false;
  bool _isLoading = false;

  final List<String> _niveaux = ['Débutant', 'Intermédiaire', 'Avancé'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      
      if (userData.exists) {
        setState(() {
          _nameController.text = userData.data()?['name'] ?? '';
          _ageController.text = (userData.data()?['age'] ?? '').toString();
          _selectedLevel = userData.data()?['level'] ?? 'Débutant';
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
            'name': _nameController.text.trim(),
            'age': int.parse(_ageController.text.trim()),
            'level': _selectedLevel,
          });

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profil mis à jour avec succès'),
                backgroundColor: Colors.green,
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erreur lors de la mise à jour du profil'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _isEditing = false;
          });
        }
      }
    }
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 30, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Une erreur est survenue'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data?.data() as Map<String, dynamic>?;

          return SingleChildScrollView(
            child: Column(
              children: [
                // En-tête du profil
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                          child: Text(
                            (userData?['name'] ?? '?')[0].toUpperCase(),
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          userData?['name'] ?? 'Utilisateur',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          userData?['email'] ?? '',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Chip(
                          label: Text(userData?['level'] ?? 'Débutant'),
                          avatar: const Icon(Icons.fitness_center),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Statistiques
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Sessions',
                          '${userData?['totalSessions'] ?? 0}',
                          Icons.event_available,
                        ),
                      ),
                      Expanded(
                        child: _buildStatCard(
                          'Minutes',
                          '${userData?['totalMinutes'] ?? 0}',
                          Icons.timer,
                        ),
                      ),
                      Expanded(
                        child: _buildStatCard(
                          'Série',
                          '${userData?['streak'] ?? 0}',
                          Icons.local_fire_department,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Formulaire de modification
                if (_isEditing)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Nom',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre nom';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _ageController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Âge',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre âge';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _selectedLevel,
                            decoration: const InputDecoration(
                              labelText: 'Niveau',
                              border: OutlineInputBorder(),
                            ),
                            items: _niveaux.map((niveau) {
                              return DropdownMenuItem(
                                value: niveau,
                                child: Text(niveau),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedLevel = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isEditing = false;
                                  });
                                },
                                child: const Text('Annuler'),
                              ),
                              ElevatedButton(
                                onPressed: _isLoading ? null : _updateProfile,
                                child: _isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('Enregistrer'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Modifier le profil'),
                          leading: const Icon(Icons.edit),
                          onTap: () {
                            setState(() {
                              _isEditing = true;
                            });
                          },
                        ),
                        ListTile(
                          title: const Text('Thème'),
                          leading: const Icon(Icons.palette),
                          trailing: Consumer<ThemeProvider>(
                            builder: (context, themeProvider, child) {
                              return Switch(
                                value: themeProvider.isDarkMode,
                                onChanged: (value) {
                                  themeProvider.toggleTheme();
                                },
                              );
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Se déconnecter'),
                          leading: const Icon(Icons.logout),
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            if (mounted) {
                              Navigator.of(context).pushReplacementNamed('/');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
