module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
    );

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			if (ena == 2'h1) begin
				q <= q << 1;  // Shift left
				q[0] <= 0;    // Ensure LSB is set to 0 after shift left
			end else if (ena == 2'h2) begin
				q <= q >> 1;  // Shift right
				q[99] <= 0;   // Ensure MSB is set to 0 after shift right
			end
		end
	end
endmodule
