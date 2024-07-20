module top_module(
    input clk,
    input d,
    output reg q);

    initial begin
        q = 1'bx; // Set initial value of q to unknown
    end

    always @(posedge clk) begin
        q <= d; // Sample d at the rising edge of clk
    end

endmodule
