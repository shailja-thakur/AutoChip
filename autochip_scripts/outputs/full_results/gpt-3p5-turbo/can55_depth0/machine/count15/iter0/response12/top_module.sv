module top_module(
	input clk,     // clock signal
	input reset,   // reset signal
	output reg [3:0] q   // 4-bit counter register
);   
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;   // reset the counter to 0
        end else begin
            q <= q + 1;     // increment the counter by 1
        end
    end
endmodule
