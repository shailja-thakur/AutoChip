module top_module (
    input a,
    input b,
    output out_and,
    output out_or,
    output out_xor,
    output out_nand,
    output out_nor,
    output out_xnor,
    output out_anotb
);
    // Gate declarations
    wire and_output;
    wire or_output;
    wire xor_output;
    wire nand_output;
    wire nor_output;
    wire xnor_output;
    wire anotb_output;

    // Gate connections
    and_gate and1(a, b, and_output);
    or_gate or1(a, b, or_output);
    xor_gate xor1(a, b, xor_output);
    nand_gate nand1(a, b, nand_output);
    nor_gate nor1(a, b, nor_output);
    xnor_gate xnor1(a, b, xnor_output);
    anotb_gate anotb1(a, b, anotb_output);

    // Output assignments
    assign out_and = and_output;
    assign out_or = or_output;
    assign out_xor = xor_output;
    assign out_nand = nand_output;
    assign out_nor = nor_output;
    assign out_xnor = xnor_output;
    assign out_anotb = anotb_output;

endmodule
module and_gate (
    input a,
    input b,
    output y
);
    assign y = a & b;
endmodule
module or_gate (
    input a,
    input b,
    output y
);
    assign y = a | b;
endmodule
module xor_gate (
    input a,
    input b,
    output y
);
    assign y = a ^ b;
endmodule
module nand_gate (
    input a,
    input b,
    output y
);
    assign y = ~(a & b);
endmodule
module nor_gate (
    input a,
    input b,
    output y
);
    assign y = ~(a | b);
endmodule
module xnor_gate (
    input a,
    input b,
    output y
);
    assign y = ~(a ^ b);
endmodule
module anotb_gate (
    input a,
    input b,
    output y
);
    assign y = a & (~b);
endmodule
