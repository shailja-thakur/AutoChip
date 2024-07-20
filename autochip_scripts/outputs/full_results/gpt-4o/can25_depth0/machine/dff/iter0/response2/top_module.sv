module top_module(
    input clk,
    input d,
    output reg q);

    // Initial block to set the initial value of the register signal q
    initial begin
        q = 1'hx;
    end

    // Always block to synchronize the data signal d with the clock signal clk
    always @(posedge clk) begin
        q <= d;
    end

endmodule
