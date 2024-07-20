module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	reg [1:0] state;
	reg [1:0] count; // Count how many times w=1 in 3 clock cycles

	parameter A = 2'd0, B = 2'd1, C = 2'd2;

	always @(posedge clk) begin
		if (reset) begin
			state <= A;
			count <= 0;
			z <= 0;
		end
		else begin
			case (state)
				A: begin
					z <= 0; // ensure z is 0 in state A
					if (s)
						state <= B;
				end
				
				B: begin
					if (count == 2) begin
						if (w)
							count <= count + 1;
						else
							count <= count;
							
						if (count == 2)
							z <= 1;
						else
							z <= 0;
						
						count <= 0; // reset count after 3 cycles
					end
					else begin
						if (w)
							count <= count + 1;
						else
							count <= count;
						
						if (count == 2)
							z <= 1;
						else
							z <= 0;
						
						count <= count + 1;
					end
				end
				
				default: state <= A;
				
			endcase
		end
	end
endmodule
