module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define the states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_t;

	reg state, next_state;
	reg out_reg;
	
	// Define the outputs for each state
	always_comb begin
		case (state)
			A: out_reg = 1'b0;
			B: out_reg = 1'b0;
			C: out_reg = 1'b0;
			D: out_reg = 1'b1;
		endcase
	end
	
	// Define the next state and output logic
	always_ff @(posedge clk) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	always_comb begin
		case ({state, in})
			{A, 1'b0}: next_state = B;
			{A, 1'b1}: next_state = A;
			{B, 1'b0}: next_state = C;
			{B, 1'b1}: next_state = B;
			{C, 1'b0}: next_state = A;
			{C, 1'b1}: next_state = D;
			{D, 1'b0}: next_state = C;
			{D, 1'b1}: next_state = B;
		endcase
	end
	
	// Assign the output
	assign out = out_reg;

endmodule
