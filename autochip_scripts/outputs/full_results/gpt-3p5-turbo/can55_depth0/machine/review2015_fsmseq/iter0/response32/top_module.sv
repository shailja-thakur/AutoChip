module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);
	
	reg [3:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 4'b0000;  // initial state is S
		else begin
			case (state)
				4'b0000: begin  // S
					if (data)
						state <= 4'b0001;  // S1
					else
						state <= 4'b0000;  // stay in S
				end
				
				4'b0001: begin  // S1
					if (data)
						state <= 4'b0011;  // S11
					else
						state <= 4'b0000;  // go back to S
				end
				
				4'b0011: begin  // S11
					if (data)
						state <= 4'b0011;  // stay in S11
					else
						state <= 4'b0110;  // S110
				end
				
				4'b0110: begin  // S110
					if (data)
						state <= 4'b1111;  // Done
					else
						state <= 4'b0000;  // go back to S
				end
				
				4'b1111: begin  // Done
					state <= 4'b1111;  // stay in Done
				end
			endcase
		end
	end
	
	assign start_shifting = (state == 4'b1111) ? 1'b1 : 1'b0;  // output is high if state is Done, otherwise low
	
endmodule
