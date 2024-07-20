module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	reg [2:0] state;
	parameter S0 = 0, S1 = 1, S2 = 2;

	// Sequential logic
	always @(posedge clk or negedge areset) begin
		if (areset == 0) begin
			state <= S0;
		end else begin
			case (state)
				S0: begin
						if (areset == 1) begin
							state <= S0;
						end else begin
							state <= S1;
						end
					end
				S1: begin
						state <= S2;
					end
				S2: begin
						state <= S0;
					end
				default: begin
						state <= S0;
					end
			endcase
		end
	end

	// Combinational logic
	always @(x or state) begin
		case (state)
			S0: begin
					z = x; // output is same as input
				end
			S1: begin
					z = ~x + 1; // output is 2's complement of input
				end
			S2: begin
					z = 0; // output is 0
				end
			default: begin
					z = 0; // default output is 0
				end
		endcase
	end

endmodule
