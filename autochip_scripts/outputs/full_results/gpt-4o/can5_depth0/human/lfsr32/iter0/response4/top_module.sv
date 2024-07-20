module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;  // Reset value
        end
        else begin
            q[31:1] <= q[30:0]; // Shift the register
            q[0] <= q[31] ^ q[21] ^ q[1] ^ q[0]; // XOR taps: 32, 22, 2, and 1
        end
    end
endmodule
