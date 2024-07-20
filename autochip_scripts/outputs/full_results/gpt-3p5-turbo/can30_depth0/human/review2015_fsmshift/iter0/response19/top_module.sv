module top_module(
	input clk,
	input reset,
	output shift_ena);
	
	reg [2:0] state;
	reg [3:0] count;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			count <= 0;
			shift_ena <= 0;
		end else begin
			case (state)
				0: begin
					if (input_pattern_detected) begin
						state <= 1;
						count <= 0;
						shift_ena <= 1;
					end
				end
				1: begin
					if (count < 3) begin
						count <= count + 1;
						shift_ena <= 1;
					end else begin
						count <= 0;
						state <= 0;
						shift_ena <= 0;
					end
				end
			endcase
		end
	end
	
endmodule
