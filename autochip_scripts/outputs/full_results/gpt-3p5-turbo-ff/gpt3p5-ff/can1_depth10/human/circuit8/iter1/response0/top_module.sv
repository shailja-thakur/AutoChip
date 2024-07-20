module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	reg [1:0] state;
	
	always @(posedge clock) begin
		case (state)
			0: begin
				p <= 0;
				q <= 0;
				if (a == 0)
					state <= 1;
				else
					state <= 2;
			end
			
			1: begin
				p <= 0;
				q <= 0;
				state <= 1;
			end
			
			2: begin
				p <= 1;
				q <= 0;
				state <= 3;
			end
			
			3: begin
				p <= 0;
				q <= 0;
				state <= 3;
			end
			
			default: begin
				p <= 0;
				q <= 0;
				state <= 0;
			end
		endcase
	end
	
endmodule
