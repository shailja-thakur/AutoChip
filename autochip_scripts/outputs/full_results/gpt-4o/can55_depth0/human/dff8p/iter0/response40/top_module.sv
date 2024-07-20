module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

always @(negedge clk) begin
    if (reset) begin
        q <= 8'h34; // Reset the D flip-flops to 0x34
    end else begin
        q <= d; // Load input data into the D flip-flops
    end
end

endmodule
