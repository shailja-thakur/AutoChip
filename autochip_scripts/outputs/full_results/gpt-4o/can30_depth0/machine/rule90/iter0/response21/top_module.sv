module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);
	always @(posedge clk) begin
		if (load)
			q <= data;
		else begin
			q <= {q[510:0], 1'b0}; // Shift right and add 0 at the end
		end
	end
endmodule
