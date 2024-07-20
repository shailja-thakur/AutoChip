module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			case (ena)
				2'b01: begin
					q <= {q[0], q[99:1]};  // Rotate right
				end
				2'b10: begin
					q <= {q[98:0], q[99]}; // Rotate left
				end
				default: begin
					q <= q;               // No change
				end
			endcase
		end
	end

endmodule
