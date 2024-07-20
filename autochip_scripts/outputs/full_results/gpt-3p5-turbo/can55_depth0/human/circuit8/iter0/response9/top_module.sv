module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);
	
	reg state;
	
	always @(posedge clock) begin
		case(state)
			// Initial State
			0: begin
				if (a == 0) begin
					state <= 0;
					p <= 0;
					q <= 0;
				end
				else begin
					state <= 1;
					p <= 0;
					q <= 0;
				end
			end
			
			// State 1
			1: begin
				if (a == 0) begin
					state <= 0;
					p <= 0;
					q <= 0;
				end
				else begin
					state <= 2;
					p <= 0;
					q <= 0;
				end
			end
			
			// State 2
			2: begin
				if (a == 0) begin
					state <= 3;
					p <= 1;
					q <= 0;
				end
				else begin
					state <= 2;
					p <= 0;
					q <= 0;
				end
			end
			
			// State 3
			3: begin
				if (a == 0) begin
					state <= 0;
					p <= 0;
					q <= 0;
				end
				else begin
					state <= 4;
					p <= 1;
					q <= 0;
				end
			end
			
			// State 4
			4: begin
				if (a == 0) begin
					state <= 0;
					p <= 0;
					q <= 0;
				end
				else begin
					state <= 5;
					p <= 1;
					q <= 0;
				end
			end
			
			// State 5
			5: begin
				if (a == 0) begin
					state <= 0;
					p <= 0;
					q <= 0;
				end
				else begin
					state <= 6;
					p <= 1;
					q <= 1;
				end
			end
			
			// State 6
			6: begin
				if (a == 0) begin
					state <= 1;
					p <= 0;
					q <= 0;
				end
				else begin
					state <= 6;
					p <= 0;
					q <= 0;
				end
			end
			
			default: state <= 0;
		endcase
	end
	
endmodule
