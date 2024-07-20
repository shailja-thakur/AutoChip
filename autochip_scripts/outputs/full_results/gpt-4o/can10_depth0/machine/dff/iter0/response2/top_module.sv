module top_module(
    input clk,
    input d,
    output reg q);

    initial begin
        q = 1'bx; // Set initial value of q to undefined
    end

    always @(posedge clk) begin
        q <= d; // On the rising edge of clk, assign d to q
    end

endmodule
