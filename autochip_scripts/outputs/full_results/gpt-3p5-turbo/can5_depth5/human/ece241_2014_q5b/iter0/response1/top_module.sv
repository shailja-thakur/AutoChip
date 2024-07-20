module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	// Declare state and next_state registers
	reg [1:0] state, next_state;
	// Declare output register
	reg z_reg;

	// Mealy machine states
	parameter A = 2'b00;
	parameter B = 2'b01;

	// Synchronous state and output updates
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
			z_reg <= 1'b0;
		end else begin
			state <= next_state;
			z_reg <= (state == B) ? 1'b1 : 1'b0;
		end
	end

	// Next state logic
	always @(*) begin
		case(state)
			A: next_state = (x == 1'b1) ? B : A;
			B: next_state = (x == 1'b0) ? B : A;
			default: next_state = A;
		endcase
	end

	// Assign output
	assign z = z_reg;
endmodule
