module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

	reg [1:0] state;
	reg q;

	always @(posedge clk) begin
		case(state)
			0: begin
				if(a & ~b) begin
					q <= 1;
					state <= 1;
				end else begin
					q <= 0;
					state <= 0;
				end
			end
			
			1: begin
				q <= 1;
				state <= 2;
			end
			
			2: begin
				if(~a & b) begin
					q <= 0;
					state <= 3;
				end else begin
					q <= 1;
					state <= 2;
				end
			end
			
			3: begin
				q <= 1;
				state <= 0;
			end
		endcase
	end
	
endmodule
