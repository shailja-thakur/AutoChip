module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	reg [2:0] state;
	
	always @(posedge clock) begin
		case (state)
			3'b000: begin
				p <= 0;
				q <= 0;
				if (a == 0)
					state <= 3'b001;
				else
					state <= 3'b000;
			end
			
			3'b001: begin
				p <= 0;
				q <= 0;
				state <= 3'b010;
			end
			
			3'b010: begin
				p <= 1;
				q <= 0;
				state <= 3'b011;
			end
			
			3'b011: begin
				p <= 0;
				q <= 0;
				state <= 3'b100;
			end
			
			3'b100: begin
				p <= 1;
				q <= 0;
				if (a == 1)
					state <= 3'b101;
				else
					state <= 3'b110;
			end
			
			3'b101: begin
				p <= 0;
				q <= 1;
				state <= 3'b111;
			end
			
			3'b110: begin
				p <= 0;
				q <= 1;
				state <= 3'b010;
			end
			
			3'b111: begin
				p <= 0;
				q <= 0;
				state <= 3'b100;
			end
		endcase
	end
	
endmodule
