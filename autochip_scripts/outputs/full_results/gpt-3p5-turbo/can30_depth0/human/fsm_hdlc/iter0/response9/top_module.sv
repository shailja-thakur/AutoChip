module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;

	reg [1:0] state;
	reg disc;
	reg flag;
	reg err;


	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S0;
			disc <= 0;
			flag <= 0;
			err <= 0;
		end else begin
			case(state)
				S0: begin
					if (in) begin
						state <= S1;
					end else begin
						state <= S0;
					end
				end
				S1: begin
					if (in) begin
						state <= S2;
					end else begin
						state <= S0;
						disc <= 0;
					end
				end
				S2: begin
					if (in) begin
						state <= S2;
						flag <= 0;
						err <= 1;
					end else begin
						state <= S0;
						disc <= 1;
					end
				end
			endcase
		end
	end

endmodule
