module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

// Assign next_state[A] based on state[A], state[C], and in
always @(state[A] or state[C] or in)
begin
	if (in == 0)
		next_state[A] = state[A] | state[C];
	else
		next_state[A] = 0;
end

// Assign next_state[B] based on state[A], state[B], state[D], and in
always @(state[A] or state[B] or state[D] or in)
begin
	if (in == 0)
		next_state[B] = 0;
	else
		next_state[B] = state[A] | state[B] | state[D];
end

// Assign next_state[C] based on state[B], state[D], and in
always @(state[B] or state[D] or in)
begin
	if (in == 0)
		next_state[C] = state[B] | state[D];
	else
		next_state[C] = 0;
end

// Assign next_state[D] based on state[C] and in
always @(state[C] or in)
begin
	if (in == 0)
		next_state[D] = 0;
	else
		next_state[D] = state[C];
end

// Assign out based on state[D]
assign out = state[D];

endmodule
