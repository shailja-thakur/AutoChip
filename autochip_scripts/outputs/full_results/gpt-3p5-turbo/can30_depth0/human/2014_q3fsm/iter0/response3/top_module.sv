module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	// Define the states
	parameter A = 0;
	parameter B = 1;

	// Define the state register
	reg [1:0] state;

	// Define the output register
	reg z_reg;

	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (s == 1) begin
						state <= B;
					end else begin
						state <= A;
					end
				end
				B: begin
					if ((w == 1 && (w === $prev(w))) && w !== $next(w)) begin
						z_reg <= 1;
					end else begin
						z_reg <= 0;
					end
					state <= A;
				end
			endcase
		end
	end

	// Assign the z output
	assign z = z_reg;

endmodule
