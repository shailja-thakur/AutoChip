module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	parameter A = 1'b0;
	parameter B = 1'b1;
	
	reg [1:0] state;
	reg [2:0] w_count;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
			w_count <= 0;
		end else begin
			case(state)
				A: begin
					if (s) state <= B;
				end
				B: begin
					if (w) w_count <= w_count + 1;
					
					if (w_count == 2)
						z <= 1;
					else
						z <= 0;
					
					if (w_count == 3) begin
						state <= A;
						w_count <= 0;
					end
				end
			endcase
		end
	end
	
endmodule
