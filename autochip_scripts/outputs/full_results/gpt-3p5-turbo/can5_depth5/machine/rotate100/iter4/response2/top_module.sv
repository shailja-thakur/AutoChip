module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);
	
	reg [99:0] shifted_data;
	
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			case(ena)
				2'b01: begin
					shifted_data[99] <= data[98];
					shifted_data[98:0] <= q[98:0];
					q <= shifted_data;
				end
				2'b10: begin
					shifted_data[0] <= q[1];
					shifted_data[99:1] <= q[99:1];
					q <= shifted_data;
				end
				default: q <= q;
			endcase
		end
	end
endmodule
