module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [3:0] state;
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;
	reg start_shifting;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else begin
			case(state)
				S0: if (data == 1'b1) state <= S1;
				S1: if (data == 1'b1) state <= S2; else state <= S0;
				S2: if (data == 1'b0) state <= S3; else state <= S0;
				S3: if (data == 1'b1) begin
						state <= S0;
						start_shifting <= 1;
					end else state <= S0;
			endcase
		end
	end

endmodule
