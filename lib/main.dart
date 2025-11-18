import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}
class Palette {
  static const Color background = Colors.black;
  static const Color surface = Color(0xFF111111);
  static const Color primaryRed = Color(0xFFE50914);
  static const Color text = Colors.white;
  static const Color muted = Colors.white70;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          background: Palette.background,
          surface: Palette.surface,
          primary: Palette.primaryRed,
          onPrimary: Palette.text,
        ),
        scaffoldBackgroundColor: Palette.background,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: Palette.text,
          ),
          bodyLarge: TextStyle(color: Palette.text),
          bodyMedium: TextStyle(color: Palette.muted),
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  static const _cvUrl = 'https://example.com/your-cv.pdf';
  static const _contactEmail = 'you@example.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 900;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 120 : 24,
                vertical: 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeroSection(isWide: isWide),
                  const SizedBox(height: 48),
                  const SectionTitle(title: 'Projects'),
                  const SizedBox(height: 16),
                  ProjectsGrid(isWide: isWide),
                  const SizedBox(height: 48),
                  const SectionTitle(title: 'Technologies'),
                  const SizedBox(height: 16),
                  const TechnologyWrap(),
                  const SizedBox(height: 48),
                  const SectionTitle(title: 'Experience'),
                  const SizedBox(height: 16),
                  const ExperienceList(),
                  const SizedBox(height: 48),
                  const SectionTitle(title: 'Contact'),
                  const SizedBox(height: 16),
                  const ContactSection(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({required this.isWide, super.key});

  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final headline = Theme.of(context).textTheme.headlineMedium;
    return Flex(
      direction: isWide ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment:
          isWide ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: isWide ? 3 : 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello, I\'m Alex Parker', style: headline),
              const SizedBox(height: 16),
              const Text(
                'Flutter developer crafting clean, responsive experiences for the web and mobile.',
                style: TextStyle(color: Palette.muted, height: 1.5),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const [
                  TagChip(label: 'Flutter'),
                  TagChip(label: 'Dart'),
                  TagChip(label: 'Firebase'),
                  TagChip(label: 'UX-focused'),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _launchUrl(PortfolioPage._cvUrl),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.primaryRed,
                      foregroundColor: Palette.text,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                    ),
                    icon: const Icon(Icons.download),
                    label: const Text('Download CV'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _launchUrl('mailto:${PortfolioPage._contactEmail}'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Palette.text,
                      side: const BorderSide(color: Palette.primaryRed, width: 1.4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                    ),
                    icon: const Icon(Icons.email_outlined),
                    label: const Text('Email me'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24, width: 24),
        Expanded(
          flex: isWide ? 2 : 0,
          child: Align(
            alignment: isWide ? Alignment.centerRight : Alignment.center,
            child: Container(
              height: isWide ? 280 : 200,
              width: isWide ? 280 : 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Palette.primaryRed, Palette.surface],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Palette.primaryRed.withOpacity(0.35),
                    blurRadius: 30,
                    spreadRadius: 4,
                    offset: const Offset(0, 18),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'AP',
                  style: TextStyle(
                    color: Palette.text,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 2,
            color: Palette.primaryRed,
          ),
        ),
      ],
    );
  }
}

class ProjectsGrid extends StatelessWidget {
  const ProjectsGrid({required this.isWide, super.key});

  final bool isWide;

  static const projects = [
    Project(
      title: 'Atlas Analytics',
      description:
          'Responsive analytics dashboard with live charts and real-time alerts for product teams.',
      technologies: ['Flutter', 'WebSockets', 'Riverpod'],
    ),
    Project(
      title: 'Beacon Events',
      description:
          'Event discovery app with offline-friendly ticket wallets and smooth animations.',
      technologies: ['Flutter', 'Firebase', 'Animations'],
    ),
    Project(
      title: 'Shift Manager',
      description:
          'Shift scheduling tool with calendar sync, notifications, and role-based access.',
      technologies: ['Flutter', 'REST APIs', 'Auth'],
    ),
    Project(
      title: 'Portfolio Web',
      description:
          'SEO-friendly personal site with responsive layouts, theming, and content tooling.',
      technologies: ['Flutter Web', 'Custom Design'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = isWide ? 2 : 1;
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - 16) / crossAxisCount;
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: projects
              .map(
                (project) => SizedBox(
                  width: itemWidth,
                  child: ProjectCard(project: project),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Palette.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Palette.primaryRed.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 32,
                width: 4,
                decoration: BoxDecoration(
                  color: Palette.primaryRed,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  project.title,
                  style: const TextStyle(
                    color: Palette.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            project.description,
            style: const TextStyle(color: Palette.muted, height: 1.5),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                project.technologies.map((tech) => TagChip(label: tech)).toList(),
          ),
        ],
      ),
    );
  }
}

class Project {
  const Project({
    required this.title,
    required this.description,
    required this.technologies,
  });

  final String title;
  final String description;
  final List<String> technologies;
}

class TagChip extends StatelessWidget {
  const TagChip({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Palette.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Palette.primaryRed.withOpacity(0.6)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Palette.text, fontSize: 12),
      ),
    );
  }
}

class TechnologyWrap extends StatelessWidget {
  const TechnologyWrap({super.key});

  static const technologies = [
    'Flutter',
    'Dart',
    'Firebase',
    'Supabase',
    'REST / GraphQL',
    'CI/CD',
    'Animations',
    'Responsive UI',
    'State Management',
    'Testing',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: technologies.map((tech) => TagChip(label: tech)).toList(),
    );
  }
}

class ExperienceList extends StatelessWidget {
  const ExperienceList({super.key});

  static const experiences = [
    Experience(
      company: 'Nova Labs',
      role: 'Senior Flutter Engineer',
      period: '2022 - Present',
      highlights: [
        'Led Flutter web migration with responsive design system.',
        'Reduced build times by 30% through CI/CD optimizations.',
        'Mentored team on state management and testing best practices.',
      ],
    ),
    Experience(
      company: 'Pulse Creative',
      role: 'Mobile Engineer',
      period: '2019 - 2022',
      highlights: [
        'Built event experience app with realtime chat and ticketing.',
        'Improved crash-free sessions to 99.4% via monitoring and QA.',
        'Collaborated with designers to refine motion and accessibility.',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...experiences.map(
          (exp) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ExperienceCard(experience: exp),
          ),
        ),
      ],
    );
  }
}

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({required this.experience, super.key});

  final Experience experience;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Palette.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Palette.primaryRed.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                experience.role,
                style: const TextStyle(
                  color: Palette.text,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              Text(
                experience.period,
                style: const TextStyle(color: Palette.muted, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            experience.company,
            style: const TextStyle(
              color: Palette.primaryRed,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: experience.highlights
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(color: Palette.primaryRed)),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(color: Palette.muted, height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class Experience {
  const Experience({
    required this.company,
    required this.role,
    required this.period,
    required this.highlights,
  });

  final String company;
  final String role;
  final String period;
  final List<String> highlights;
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static const socials = [
    SocialLink(label: 'Email', value: 'you@example.com', url: 'mailto:you@example.com'),
    SocialLink(
      label: 'GitHub',
      value: 'github.com/yourhandle',
      url: 'https://github.com/yourhandle',
    ),
    SocialLink(
      label: 'LinkedIn',
      value: 'linkedin.com/in/yourprofile',
      url: 'https://www.linkedin.com/in/yourprofile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Let\'s build something impactful. Reach out for collaborations, consulting, or just to say hi.',
          style: TextStyle(color: Palette.muted, height: 1.5),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: socials
              .map(
                (social) => OutlinedButton(
                  onPressed: () => _launchUrl(social.url),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Palette.text,
                    side: const BorderSide(color: Palette.primaryRed, width: 1.2),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        social.label,
                        style: const TextStyle(
                          color: Palette.primaryRed,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(social.value, style: const TextStyle(color: Palette.text)),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class SocialLink {
  const SocialLink({required this.label, required this.value, required this.url});

  final String label;
  final String value;
  final String url;
}

Future<void> _launchUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
