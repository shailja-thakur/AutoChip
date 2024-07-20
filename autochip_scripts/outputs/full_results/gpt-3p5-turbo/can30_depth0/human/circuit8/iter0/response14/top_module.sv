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
				if (a == 1)
					state <= 1;
			end
			1: begin
				p <= 0;
				q <= 0;
				if (a == 0)
					state <= 2;
			end
			2: begin
				p <= 1;
				q <= 0;
				state <= 3;
			end
			3: begin
				p <= 0;
				q <= 0;
				if (a == 1)
					state <= 4;
			end
			4: begin
				p <= 1;
				q <= 1;
				state <= 5;
			end
			5: begin
				p <= 0;
				q <= 1;
				if (a == 0)
					state <= 6;
			end
			6: begin
				p <= 0;
				q <= 1;
				state <= 7;
			end
			7: begin
				p <= 0;
				q <= 1;
				if (a == 0)
					state <= 0;
			end
		endcase
	end
	
endmodule
