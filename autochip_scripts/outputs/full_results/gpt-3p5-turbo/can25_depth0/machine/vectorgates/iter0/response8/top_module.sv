module top_module(
    input [2:0] a,
    input [2:0] b,
    output reg [2:0] out_or_bitwise,
    output reg out_or_logical,
    output reg [5:0] out_not
);
    // Bitwise OR operation
    assign out_or_bitwise = a | b;

    // Logical OR operation
    always @*
    begin
        if (a || b)
            out_or_logical = 1;
        else
            out_or_logical = 0;
    end

    // Bitwise NOT operation
    always @*
    begin
        out_not = ~{b, a};
    end
endmodule
