module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	reg [1:0] state;
	always @(posedge clk, posedge reset)
	begin
		if(reset)
			state <= 2'b00;
		else
		begin
			case(state)
				2'b00:
				begin
					if(s)
						state <= 2'b01;
					else
						state <= 2'b00;
				end
				
				2'b01:
				begin
					state <= 2'b10;
				end
				
				2'b10:
				begin
					if(w)
						state <= 2'b11;
					else
						state <= 2'b01;
				end
				
				2'b11:
				begin
					if(w)
						state <= 2'b11;
					else
						state <= 2'b10;
				end
			endcase
		end
	end
	
	always @(state, w)
	begin
		if(state == 2'b11)
		begin
			if(w)
				z <= 1'b1;
			else
				z <= 1'b0;
		end
		else
		begin
			z <= 1'b0;
		end
	end
	
endmodule
