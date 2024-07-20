module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// State encoding
	localparam [2:0] A = 3'b000,
	                 B = 3'b001,
	                 C = 3'b010,
	                 D = 3'b011,
	                 E = 3'b100,
	                 F = 3'b101;

	reg [2:0] state, next_state;

	// State transition
	always @(*) begin
		case (state)
			A: next_state = (w == 1'b0) ? B : A;
			B: next_state = (w == 1'b0) ? C : D;
			C: next_state = (w == 1'b0) ? E : D;
			D: next_state = (w == 1'b0) ? F : A;
			E: next_state = (w == 1'b0) ? E : D;
			F: next_state = (w == 1'b0) ? C : D;
			default: next_state = A;
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (state)
			E, F: z = 1'b1;
			default: z = 1'b0;
		endcase
	end

endmodule
