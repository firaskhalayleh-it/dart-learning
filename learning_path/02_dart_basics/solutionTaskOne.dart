
// Simple User System Implementation

// Define available user roles
enum Role { user, admin }

// User profile record with required and optional fields
typedef UserProfile = ({
  int id,           // Unique user identifier
  String name,      // User's display name
  String email,     // User's email address
  String? avatar,   // Optional profile picture URL
  String? bio       // Optional user biography
});

// Complete user record with profile, roles, and skills
typedef User = ({
  UserProfile profile,    // User's basic profile information
  List<Role> roles,      // User's assigned roles
  Set<String> skills     // User's skills set (no duplicates)
});

// User management system with array of users
class UserSystem {
  List<User> users = [];  // Array to store all users
}

// Create a new user with basic information
User createUser({
  required int id,
  required String name,
  required String email,
  String? avatar,
  String? bio,
  List<Role>? roles,
  Set<String>? skills,
}) {
  return (
    profile: (
      id: id,
      name: name,
      email: email,
      avatar: avatar,
      bio: bio,
    ),
    roles: roles ?? [Role.user],        // Default to basic user role
    skills: skills ?? <String>{},       // Default to empty skills set
  );
}

// Add a new role to an existing user
User addRole(User user, Role newRole) {
  return (
    profile: user.profile,
    roles: [...user.roles, newRole],    // Add new role to existing roles
    skills: user.skills,
  );
}

// Add new skills to an existing user
User addSkills(User user, Set<String> newSkills) {
  return (
    profile: user.profile,
    roles: user.roles,
    skills: {...user.skills, ...newSkills},  // Merge skills sets (no duplicates)
  );
}

// Update user profile information
User updateProfile(User user, {
  String? name,
  String? email,
  String? avatar,
  String? bio,
}) {
  return (
    profile: (
      id: user.profile.id,                    // ID never changes
      name: name ?? user.profile.name,        // Use new name or keep existing
      email: email ?? user.profile.email,    // Use new email or keep existing
      avatar: avatar ?? user.profile.avatar, // Use new avatar or keep existing
      bio: bio ?? user.profile.bio,          // Use new bio or keep existing
    ),
    roles: user.roles,
    skills: user.skills,
  );
}

// User management functions for the array of users
UserSystem userSystem = UserSystem();  // Global user system instance

// Add a user to the system
void addUserToSystem(User user) {
  userSystem.users.add(user);  // Add user to the array
}

// Find a user by ID in the system
User? findUserById(int id) {
  for (User user in userSystem.users) {  // Search through the array
    if (user.profile.id == id) {
      return user;
    }
  }
  return null;  // User not found
}

// Get all users in the system
List<User> getAllUsers() {
  return userSystem.users;  // Return the array of users
}

// Example usage
void main() {
  // Create multiple users
  var user1 = createUser(
    id: 1,
    name: 'Firas',
    email: 'firas@gmail.com',
    bio: 'MLOps Engineer',
    roles: [Role.user],  // Default to basic user role
  );

  var user2 = createUser(
    id: 2,
    name: 'Ahmad',
    email: 'ahmad@gmail.com',
    skills: {'JavaScript', 'React'},  // Using set for skills
    roles: [Role.user],  // Default to basic user role
  );

  // Add skills to user1 (sets automatically handle duplicates)
  user1 = addSkills(user1, {'Dart', 'Flutter'});  // Sets prevent duplicates automatically

  // Promote user1 to admin
  user1 = addRole(user1, Role.admin);

  // Add users to the system array
  addUserToSystem(user1);
  addUserToSystem(user2);

  // Display all users in the system
  print('=== User System ===');
  for (User user in getAllUsers()) {
    print('User: ${user.profile.name}');
    print('Email: ${user.profile.email}');
    print('Roles: ${user.roles}');
    print('Skills: ${user.skills}');
    print('---');
  }

  // Find a specific user
  User? foundUser = findUserById(1);
  if (foundUser != null) {
    print('Found user: ${foundUser.profile.name}');
  }
}
