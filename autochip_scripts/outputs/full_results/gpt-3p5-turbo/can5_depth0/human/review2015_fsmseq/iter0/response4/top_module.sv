module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);
	
	reg [3:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else begin
			case(state)
				0: if (data == 1'd1)
						state <= 1;
					else
						state <= 0;
				1: if (data == 1'd1)
						state <= 2;
					else
						state <= 0;
				2: if (data == 1'd0)
						state <= 3;
					else
						state <= 0;
				3: if (data == 1'd1) begin
						state <= 0;
						start_shifting <= 1;
					end
					else
						state <= 0;
			endcase
		end
	end
endmodule
