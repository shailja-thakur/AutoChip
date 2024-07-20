module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] lfsr;

    always @(posedge clk or posedge reset) begin
        if (reset)
            lfsr <= 1;
        else
            lfsr <= lfsr^1 & lfsr^3;
    end

    assign q = lfsr;

endmodule
