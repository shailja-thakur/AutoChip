module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	reg [99:0] temp; // temporary variable to hold the shifted bits
	
	always @(posedge clk) begin
		if (load) begin
			q <= data; // load the shift register with data
		end else begin
			case (ena)
				2'b01: begin // rotate right
					temp[0] <= q[99];
					temp[1:99] <= q[0:98];
					q <= temp;
				end
				2'b10: begin // rotate left
					temp[0:98] <= q[1:99];
					temp[99] <= q[0];
					q <= temp;
				end
				default: begin // no rotation
					q <= q;
				end
			endcase
		end
	end

endmodule
