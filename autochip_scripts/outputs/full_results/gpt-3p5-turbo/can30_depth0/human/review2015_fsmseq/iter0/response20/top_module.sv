module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	parameter INIT = 0;
	parameter S0 = 1;
	parameter S1 = 2;
	parameter S2 = 3;
	parameter S3 = 4;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= INIT;
			start_shifting <= 0;
		end else begin
			case (state)
				INIT: begin
					if (data == 1'b1)
						state <= S0;
					else
						state <= INIT;
				end
				S0: begin
					if (data == 1'b1)
						state <= S0;
					else
						state <= S1;
				end
				S1: begin
					if (data == 1'b1)
						state <= S2;
					else
						state <= INIT;
				end
				S2: begin
					if (data == 1'b1)
						state <= S0;
					else
						state <= S3;
				end
				S3: begin
					if (data == 1'b1) begin
						state <= S2;
						start_shifting <= 1;
					end else begin
						state <= S1;
						start_shifting <= 0;
					end
				end
			endcase
		end
	end

endmodule
