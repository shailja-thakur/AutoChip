module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [2:0] state;
	reg start_shifting;
	reg prev_data;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			start_shifting <= 0;
		end
		else begin
			prev_data <= data;
			case (state)
				0: begin
					if (prev_data == 1'b1)
						state <= 1;
				end
				1: begin
					if (prev_data == 1'b1)
						state <= 2;
					else
						state <= 0;
				end
				2: begin
					if (prev_data == 1'b0)
						state <= 3;
					else
						state <= 0;
				end
				3: begin
					if (prev_data == 1'b1) begin
						state <= 0;
						start_shifting <= 1;
					end
					else
						state <= 0;
				end
			endcase
		end
	end
endmodule
