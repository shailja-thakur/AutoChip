module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// FSM state declaration
	reg [1:0] state, next_state;

	// State parameter declaration
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	// Output reg declaration
	reg out_reg;

	// State register
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Next state logic
	always @* begin
		case(state)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
			end
			D: begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
			default: next_state = A;
		endcase
	end

	// Output assignment
	always @(state) begin
		if (state == D)
			out_reg = 1'b1;
		else
			out_reg = 1'b0;
	end

	// Output register
	assign out = out_reg;

endmodule
