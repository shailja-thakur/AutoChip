module top_module(
    input clk,
    input d,
    output reg q
);

    // Register signal q, initialized as 1'hx
    reg q = 1'hx;

    // Synchronize the data signal d with the clock signal clk
    always @(posedge clk) begin
        q <= d;
    end

endmodule
