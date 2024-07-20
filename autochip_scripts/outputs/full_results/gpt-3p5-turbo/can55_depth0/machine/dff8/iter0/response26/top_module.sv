module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    // Default initial value of the register
    initial begin
        q = 8'h0;
    end

    // Sequential logic triggered on the rising edge of the clock
    always @(posedge clk) begin
        q <= d;
    end

endmodule
