module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);
	
	reg [99:0] temp;

	always @(posedge clk) begin
		if (load)
			q <= data;
		else begin
			case (ena)
				2'b01: begin // Shift left
					temp[98:0] <= q[99:1];
					temp[99] <= 1'b0;
					q <= temp;
				end
				2'b10: begin // Shift right
					temp[1:99] <= q[0:98];
					temp[0] <= 1'b0;
					q <= temp;
				end
				default: q <= q; // No shift
			endcase
		end
	end
endmodule
