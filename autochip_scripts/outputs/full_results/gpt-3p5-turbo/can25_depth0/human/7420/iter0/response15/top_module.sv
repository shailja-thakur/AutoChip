module top_module(
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    output p1y,
    input p2a,
    input p2b,
    input p2c,
    input p2d,
    output p2y
);

    wire p1_y1;
    wire p2_y1;

    nand_gate_g1 nand1 (.a(p1a), .b(p1b), .c(p1c), .d(p1d), .y(p1_y1));
    nand_gate_g2 nand2 (.a(p2a), .b(p2b), .c(p2c), .d(p2d), .y(p2_y1));

    not_gate_g3 not1 (.a(p1_y1), .y(p1y));
    not_gate_g4 not2 (.a(p2_y1), .y(p2y));

endmodule
module nand_gate_g1 (input a, input b, input c, input d, output y);
    wire intermediate_wire1;
    wire intermediate_wire2;

    nand_gate nand_1 (.a(a), .b(b), .y(intermediate_wire1));
    nand_gate nand_2 (.a(c), .b(d), .y(intermediate_wire2));
    nand_gate nand_3 (.a(intermediate_wire1), .b(intermediate_wire2), .y(y));
endmodule
module nand_gate_g2 (input a, input b, input c, input d, output y);
    wire intermediate_wire1;
    wire intermediate_wire2;

    nand_gate nand_1 (.a(a), .b(b), .y(intermediate_wire1));
    nand_gate nand_2 (.a(c), .b(d), .y(intermediate_wire2));
    nand_gate nand_3 (.a(intermediate_wire1), .b(intermediate_wire2), .y(y));
endmodule
module not_gate_g3 (input a, output y);
    not_gate not1 (.a(a), .y(y));
endmodule
module not_gate_g4 (input a, output y);
    not_gate not1 (.a(a), .y(y));
endmodule
module nand_gate (input a, input b, output y);
    assign y = ~(a & b);
endmodule
module not_gate (input a, output y);
    assign y = ~a;
endmodule
