module top_module(
    input clk,
    input d,
    output reg q);

    initial begin
        q = 1'bx; // Initialize q to an unknown value
    end

    always @(posedge clk) begin
        q <= d; // On the rising edge of clk, set q to the value of d
    end

endmodule
