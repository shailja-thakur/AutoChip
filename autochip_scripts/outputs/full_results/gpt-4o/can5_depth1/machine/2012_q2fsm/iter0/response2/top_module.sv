module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// State definitions
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;

	reg [2:0] state, next_state;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) 
			state <= A;
		else 
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: next_state = (w) ? B : A;
			B: next_state = (w) ? C : D;
			C: next_state = (w) ? E : D;
			D: next_state = (w) ? F : A;
			E: next_state = (w) ? E : D;
			F: next_state = (w) ? C : D;
			default: next_state = A;
		endcase
	end

	// Output logic
	assign z = (state == E) || (state == F);

endmodule
