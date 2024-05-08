module top_module( 
    input [2:0] a,
    input [2:0] b,
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);

    wire [2:0] or_bitwise;
    wire [2:0] or_logical;
    wire [5:0] not_a;
    wire [5:0] not_b;

    or_bitwise = a | b;
    or_logical = a or b;
    not_a = ~a;
    not_b = ~b;

    out_not [5:3] = not_b;
    out_not [2:0] = not_a;

endmodule