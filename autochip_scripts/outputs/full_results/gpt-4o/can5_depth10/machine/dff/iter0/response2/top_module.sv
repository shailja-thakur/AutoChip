module top_module(
    input clk,
    input d,
    output reg q);

initial begin
    q = 1'bx;  // Set initial value to unknown/undefined
end

always @(posedge clk) begin
    q <= d;  // Synchronize data signal with clock signal
end

endmodule
