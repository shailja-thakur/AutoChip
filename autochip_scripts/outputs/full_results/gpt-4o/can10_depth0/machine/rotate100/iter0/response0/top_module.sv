module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	// Always block, triggered on rising edge of clock
	always @(posedge clk) begin
		if (load) begin
			// Load data into q
			q <= data;
		end else begin
			// Shift based on ena
			case (ena)
				2'h1: q <= q << 1;
				2'h2: q <= q >> 1;
				default: q <= q; // Hold value if ena is not 1 or 2
			endcase
		end
	end

endmodule
