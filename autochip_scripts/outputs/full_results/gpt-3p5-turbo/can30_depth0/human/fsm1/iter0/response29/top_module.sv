module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	// Define the states
	typedef enum logic [1:0] {
		B,
		A
	} state_t;
	
	// Define the next state logic table
	table next_state_table [
		2'b00: B,
		2'b01: A,
		2'b10: B,
		2'b11: A
	];
	
	// Define the output logic table
	table output_table [
		2'b00: 0,
		2'b01: 1,
		2'b10: 0,
		2'b11: 1
	];
	
	// Define the current state and next state wires
	logic [1:0] curr_state, next_state;
	// Define the output wire
	logic out;
	
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			curr_state <= B;
		end else begin
			curr_state <= next_state;
		end
	end
	
	always_comb begin
		next_state = next_state_table[curr_state];
		out = output_table[curr_state];
	end
endmodule
