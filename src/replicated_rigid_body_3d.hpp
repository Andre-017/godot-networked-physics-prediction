#pragma once

#include <godot_cpp/classes/rigid_body3d.hpp>

using namespace godot;

class ReplicatedRigidBody3D : public RigidBody3D
{
	GDCLASS(ReplicatedRigidBody3D, RigidBody3D);

protected:
	static void _bind_methods();

public:
	ReplicatedRigidBody3D();
	~ReplicatedRigidBody3D();

	void _ready() override;
	void _process(double delta) override;

	godot::String hello_node();
};
