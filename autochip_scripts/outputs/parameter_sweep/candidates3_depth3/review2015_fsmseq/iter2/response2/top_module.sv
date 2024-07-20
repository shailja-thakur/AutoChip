module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg [2:0] shift;
	
	always @(posedge clk, posedge reset) begin
		if (reset == 1'b1) begin
			state <= 0;
			shift <= 3'b0;
			start_shifting <= 0;
		end
		else begin
			case (state)
				0: begin
					if (data == 1'b1)
						state <= 1;
				end
				1: begin
					if (data == 1'b1)
						state <= 2;
					else
						state <= 0;
				end
				2: begin
					if (data == 1'b0)
						state <= 3;
					else
						state <= 0;
				end
				3: begin
					if (data == 1'b1) begin
						state <= 4;
						start_shifting <= 1;
					end
					else begin
						state <= 0;
						start_shifting <= 0;
					end
				end
				4: begin
					start_shifting <= 1;
					state <= 2;
				end
				default: state <= 0;
			endcase
		end
	end
	
endmodule
