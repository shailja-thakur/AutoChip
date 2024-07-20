module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// State Encoding
	localparam A = 3'b000;
	localparam B = 3'b001;
	localparam C = 3'b010;
	localparam D = 3'b011;
	localparam E = 3'b100;

	reg [2:0] state, next_state;

	// Combinational logic for the next state
	always @(*) begin
		case (state)
			A: next_state = x ? B : A;
			B: next_state = x ? E : B;
			C: next_state = x ? B : C;
			D: next_state = x ? C : B;
			E: next_state = x ? E : D;
			default: next_state = A; // Default state
		endcase
	end

	// Sequential logic for state transition
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		z = (state == D) || (state == E);
	end

endmodule
