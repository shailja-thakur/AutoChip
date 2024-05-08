module top_module( 
    input a, b,
    output out_and,
    output out_or,
    output out_xor,
    output out_nand,
    output out_nor,
    output out_xnor,
    output out_anotb
);

    wire and = a & b;
    wire or = a | b;
    wire xor = a ^ b;
    wire nand = !(a & b);
    wire nor = !(a | b);
    wire xnor = !(a ^ b);
    wire anotb = !(a & !b);

    assign out_and = and;
    assign out_or = or;
    assign out_xor = xor;
    assign out_nand = nand;
    assign out_nor = nor;
    assign out_xnor = xnor;
    assign out_anotb = anotb;

endmodule