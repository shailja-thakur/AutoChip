module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	parameter IDLE = 2'b00;
	parameter CONVERTING = 2'b01;
	
	reg [1:0] state;
	reg prev_x;
	
	always @(posedge clk or negedge areset) begin
		if (areset == 0) begin
			state <= IDLE;
			prev_x <= 0;
		end
		else begin
			prev_x <= x;
			case (state)
				IDLE: begin
					if (areset == 1)
						state <= IDLE;
					else if (x == 1'b1)
						state <= CONVERTING;
				end
				
				CONVERTING: begin
					if (x == prev_x)
						state <= CONVERTING;
					else
						state <= IDLE;
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (areset == 0) begin
			z <= 1'b0;
		end
		else begin
			case (state)
				IDLE: begin
					z <= 1'b0;
				end
				
				CONVERTING: begin
					if (x == 1'b1)
						z <= ~z;
				end
			endcase
		end
	end
endmodule
