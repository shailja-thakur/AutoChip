module top_module(
	input clk,
	input reset,
	output shift_ena);
	
	reg [3:0] state;
	reg [3:0] next_state;
	
	parameter IDLE = 4'b0000;
	parameter ENABLE = 4'b0001;
	parameter SHIFT = 4'b0010;
	
	always @(posedge clk) begin
		if(reset)
			state <= IDLE;
		else
			state <= next_state;
	end
	
	always @(state) begin
		case(state)
			IDLE: begin
				next_state = ENABLE;
				shift_ena = 1'b1;
			end
			
			ENABLE: begin
				if(shift_ena == 4'b1111)
					next_state = SHIFT;
				else
					next_state = ENABLE;
				shift_ena = shift_ena + 1'b1;
			end
			
			SHIFT: begin
				next_state = IDLE;
				shift_ena = 1'b0;
			end
		endcase
	end
	
endmodule
