module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	// Define four states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	reg [1:0] state; // State variable
	reg out_reg; // Output register

	// Reset the FSM to state A with synchronous active high reset
	always @(posedge clk) begin
		if (reset) begin
			state <= A;
			out_reg <= 0;
		end else begin
			case (state)
				A: begin
					if (in)
						state <= B;
					else
						state <= A;
					out_reg <= 0;
				end
				B: begin
					if (in)
						state <= C;
					else
						state <= B;
					out_reg <= 0;
				end
				C: begin
					if (in)
						state <= A;
					else
						state <= D;
					out_reg <= 0;
				end
				D: begin
					if (in)
						state <= C;
					else
						state <= B;
					out_reg <= 1;
				end
			endcase
		end
	end

	// Assign output
	always @(state) begin
		out = out_reg;
	end

endmodule
