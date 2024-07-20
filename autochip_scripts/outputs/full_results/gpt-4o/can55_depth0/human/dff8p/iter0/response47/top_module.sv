module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

    // Initial block to set q to 0x34 (52 in decimal) on reset
    initial begin
        q = 8'h34;
    end

    always @(negedge clk) begin
        if (reset) begin
            q <= 8'h34; // Reset to 0x34
        end else begin
            q <= d;
        end
    end

endmodule
