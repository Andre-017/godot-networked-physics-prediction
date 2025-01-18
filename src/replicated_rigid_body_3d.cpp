#include "replicated_rigid_body_3d.hpp"

#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void ReplicatedRigidBody3D::_bind_methods()
{
	ClassDB::bind_method(D_METHOD("hello_node"), &ReplicatedRigidBody3D::hello_node);
}

ReplicatedRigidBody3D::ReplicatedRigidBody3D()
{
}

ReplicatedRigidBody3D::~ReplicatedRigidBody3D()
{
}

// Override built-in methods with your own logic. Make sure to declare them in the header as well!

void ReplicatedRigidBody3D::_ready()
{

}

void ReplicatedRigidBody3D::_process(double delta)
{
}

godot::String ReplicatedRigidBody3D::hello_node()
{
	return "Hello GDExtension Node\n";
}
