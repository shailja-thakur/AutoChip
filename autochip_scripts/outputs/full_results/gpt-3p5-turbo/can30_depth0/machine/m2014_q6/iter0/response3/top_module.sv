module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);
	reg [2:0] state;

	always @(posedge clk) begin
		if (reset)
			state <= 0;
		else begin
			case (state)
				0: begin
					if (w)
						state <= 0;
					else
						state <= 1;
				end
				
				1: begin
					if (w)
						state <= 3;
					else
						state <= 2;
				end
				
				2: begin
					if (w)
						state <= 3;
					else
						state <= 4;
				end
				
				3: begin
					if (w)
						state <= 0;
					else
						state <= 5;
				end
				
				4: begin
					if (w)
						state <= 2;
					else
						state <= 4;
				end
				
				5: begin
					if (w)
						state <= 3;
					else
						state <= 2;
				end
			endcase
		end
	end
	
	always @(state) begin
		if (state == 4 || state == 5)
			z = 1;
		else
			z = 0;
	end
	
endmodule
