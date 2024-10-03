import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lorem Ipsum',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Avenir LT 55 Roman',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 50),
                      Row(
                        children: [
                          Icon(Icons.bookmark_border,
                              color: Colors.white, size: 24),
                          SizedBox(width: 8),
                          Text(
                            'Lajmet e ruajtura',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Avenir LT 55 Roman',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/image/profile-big.png'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Cilësimet',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              _buildSettingItem(
                  context, 'Llogaria ime', Icons.arrow_forward_outlined),
              _buildSettingItem(context, 'Kushtet e Privatësisë',
                  Icons.arrow_forward_outlined),
              _buildSettingItem(
                  context, 'Menaxhoj njoftimet', Icons.arrow_forward_outlined),
              _buildSwitchItem('Dark mode'),
              _buildSettingItem(
                  context, 'Denonco', Icons.arrow_forward_outlined,
                  isDenonco: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, IconData icon,
      {bool isDenonco = false}) {
    return GestureDetector(
      onTap: () {
        if (isDenonco) {
          context.push('/denonco');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (isDenonco)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    margin: const EdgeInsets.only(right: 8),
                  ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Avenir LT 55 Roman',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Icon(icon, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Avenir LT 55 Roman',
              fontWeight: FontWeight.w400,
            ),
          ),
          Switch(
            value: true,
            activeColor: Colors.white,
            onChanged: (bool value) {},
          ),
        ],
      ),
    );
  }
}
