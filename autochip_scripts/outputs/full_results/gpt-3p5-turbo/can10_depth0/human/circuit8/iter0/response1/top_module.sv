module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	reg state;

	always @(posedge clock) begin
		case (state)
			0: begin
				if (a == 0) begin
					p <= 0;
					q <= 0;
					state <= 0;
				end else begin
					p <= 0;
					q <= 0;
					state <= 1;
				end
			end
			
			1: begin
				if (a == 0) begin
					p <= 0;
					q <= 0;
					state <= 2;
				end else begin
					p <= 0;
					q <= 0;
					state <= 1;
				end
			end
			
			2: begin
				if (a == 0) begin
					p <= 0;
					q <= 0;
					state <= 2;
				end else begin
					p <= 0;
					q <= 0;
					state <= 3;
				end
			end
			
			3: begin
				if (a == 0) begin
					p <= 0;
					q <= 0;
					state <= 3;
				end else begin
					p <= 0;
					q <= 0;
					state <= 4;
				end
			end
			
			4: begin
				if (a == 0) begin
					p <= 0;
					q <= 0;
					state <= 4;
				end else begin
					p <= 0;
					q <= 0;
					state <= 4;
				end
			end
			
			5: begin
				if (a == 0) begin
					p <= 0;
					q <= 0;
					state <= 6;
				end else begin
					p <= 0;
					q <= 0;
					state <= 5;
				end
			end
			
			6: begin
				if (a == 1) begin
					p <= 0;
					q <= 0;
					state <= 7;
				end else begin
					p <= 0;
					q <= 0;
					state <= 8;
				end
			end
			
			7: begin
				if (a == 0) begin
					p <= 0;
					q <= 0;
					state <= 9;
				end else begin
					p <= 0;
					q <= 0;
					state <= 10;
				end
			end
			
			8: begin
				if (a == 1) begin
					p <= 1;
					q <= 0;
					state <= 8;
				end else begin
					p <= 0;
					q <= 0;
					state <= 11;
				end
			end
			
			9: begin
				if (a == 1) begin
					p <= 1;
					q <= 1;
					state <= 9;
				end else begin
					p <= 0;
					q <= 0;
					state <= 11;
				end
			end
			
			10: begin
				if (a == 1) begin
					p <= 1;
					q <= 0;
					state <= 10;
				end else begin
					p <= 0;
					q <= 0;
					state <= 11;
				end
			end
			
			11: begin
				if (a == 1) begin
					p <= 1;
					q <= 1;
					state <= 11;
				end else begin
					p <= 0;
					q <= 0;
					state <= 11;
				end
			end
			
			12: begin
				if (a == 0) begin
					p <= 1;
					q <= 1;
					state <= 12;
				end else begin
					p <= 0;
					q <= 1;
					state <= 13;
				end
			end
			
			13: begin
				if (a == 0) begin
					p <= 0;
					q <= 0;
					state <= 13;
				end else begin
					p <= 0;
					q <= 0;
					state <= 14;
				end
			end
			
			14: begin
				if (a == 1) begin
					p <= 0;
					q <= 0;
					state <= 15;
				end else begin
					p <= 0;
					q <= 0;
					state <= 14;
				end
			end
			
			15: begin
				if (a == 1) begin
					p <= 0;
					q <= 0;
					state <= 16;
				end else begin
					p <= 0;
					q <= 1;
					state <= 14;
				end
			end
			
			16: begin
				if (a == 1) begin
					p <= 1;
					q <= 1;
					state <= 16;
				end else begin
					p <= 1;
					q <= 1;
					state <= 17;
				end
			end
			
			17: begin
				if (a == 1) begin
					p <= 0;
					q <= 0;
					state <= 18;
				end else begin
					p <= 1;
					q <= 1;
					state <= 19;
				end
			end
			
			18: begin
				if (a == 0) begin
					p <= 1;
					q <= 0;
					state <= 0;
				end else begin
					p <= 0;
					q <= 0;
					state <= 18;
				end
			end
			
			default: begin
				p <= 0;
				q <= 0;
				state <= 0;
			end
		endcase
	end
	
endmodule
