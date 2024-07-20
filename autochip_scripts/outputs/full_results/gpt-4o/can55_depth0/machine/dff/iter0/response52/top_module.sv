module top_module(
    input clk,
    input d,
    output reg q);

    // Initialize q to an unknown value
    initial begin
        q = 1'bx;
    end

    // On the rising edge of the clock, set q to the value of d
    always @(posedge clk) begin
        q <= d;
    end

endmodule
