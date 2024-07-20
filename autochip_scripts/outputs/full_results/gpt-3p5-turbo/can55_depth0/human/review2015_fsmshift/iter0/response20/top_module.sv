module top_module(
	input clk,
	input reset,
	output shift_ena);
	
	reg [2:0] state;
	parameter [2:0] S0 = 3'b000;
	parameter [2:0] S1 = 3'b001;
	
	reg [1:0] count;
	parameter [1:0] COUNT_MAX = 2'b11;
	
	always @(posedge clk or posedge reset)
	begin
		if (reset)
		begin
			state <= S0;
			count <= 0;
			shift_ena <= 1'b1;
		end
		else
		begin
			case (state)
				S0: begin
					if (count == COUNT_MAX)
					begin
						state <= S1;
						count <= 0;
						shift_ena <= 1'b0;
					end
					else
						count <= count + 1;
				end
				S1: begin
					state <= S0;
					count <= 0;
					shift_ena <= 1'b1;
				end
			endcase
		end
	end
	
endmodule
