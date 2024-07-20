module top_module(
    input clk,
    input d,
    output reg q);

    // Initial value of the register q is unknown (undefined)
    initial begin
        q = 1'hx;
    end

    // Synchronize the data signal d with the clock signal clk
    always @(posedge clk) begin
        q <= d;
    end

endmodule
