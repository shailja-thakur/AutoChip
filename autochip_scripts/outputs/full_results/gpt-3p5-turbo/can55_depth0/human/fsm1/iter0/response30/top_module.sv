module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state, next_state;
	reg out_reg;

	// State assignments
	parameter B = 2'b00;
	parameter A = 2'b01;

	// Output assignments
	parameter out_B = 1'b1;
	parameter out_A = 1'b0;

	// Asynchronous reset - reset to B state
	always @ (areset) begin
		if (areset) begin
			state <= B;
			out_reg <= out_B;
		end
	end

	// Synchronous logic
	always @ (posedge clk) begin
		if (!areset) begin
			state <= next_state;
			out_reg <= (state == B) ? out_B : out_A;
		end
	end

	// Next state and output logic
	always @ (*) begin
		case (state)
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
			end
		endcase
	end

	assign out = out_reg;

endmodule
