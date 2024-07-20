module top_module(
    input [2:0] a,
    input [2:0] b,
    output reg [2:0] out_or_bitwise,
    output reg out_or_logical,
    output reg [5:0] out_not
);

    always @(a, b)
    begin
        out_or_bitwise = a | b;
        out_or_logical = (a != 0) || (b != 0);
        out_not[2:0] = ~a;
        out_not[5:3] = ~b;
    end

endmodule
