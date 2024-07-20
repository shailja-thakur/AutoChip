module top_module(
    input [7:0] p1,
    output p1y,
    input [7:0] p2,
    output p2y
);

    wire [3:0] nand1_out;
    wire [3:0] nand2_out;

    nand_gate_4 p1_nand_gate1(
        .a(p1[0]),
        .b(p1[1]),
        .c(p1[2]),
        .d(p1[3]),
        .y(nand1_out[0])
    );

    nand_gate_4 p2_nand_gate1(
        .a(p2[0]),
        .b(p2[1]),
        .c(p2[2]),
        .d(p2[3]),
        .y(nand2_out[0])
    );

    nand_gate_4 p1_nand_gate2(
        .a(p1[4]),
        .b(p1[5]),
        .c(p1[6]),
        .d(p1[7]),
        .y(nand1_out[1])
    );

    nand_gate_4 p2_nand_gate2(
        .a(p2[4]),
        .b(p2[5]),
        .c(p2[6]),
        .d(p2[7]),
        .y(nand2_out[1])
    );

    nand_gate_4 nand_gate3(
        .a(nand1_out[0]),
        .b(nand1_out[1]),
        .c(1'b1),
        .d(1'b1),
        .y(nand1_out[2])
    );

    nand_gate_4 nand_gate4(
        .a(nand2_out[0]),
        .b(nand2_out[1]),
        .c(1'b1),
        .d(1'b1),
        .y(nand2_out[2])
    );

    nand_gate_4 nand_gate5(
        .a(nand1_out[2]),
        .b(p1[2]),
        .c(p1[3]),
        .d(1'b1),
        .y(p1y)
    );

    nand_gate_4 nand_gate6(
        .a(nand2_out[2]),
        .b(p2[2]),
        .c(p2[3]),
        .d(1'b1),
        .y(p2y)
    );

endmodule
module nand_gate_4(
    input a,
    input b,
    input c,
    input d,
    output y
);

    wire [3:0] temp_wire;

    nand_gate nand1(
        .a(a),
        .b(b),
        .y(temp_wire[0])
    );

    nand_gate nand2(
        .a(c),
        .b(d),
        .y(temp_wire[1])
    );

    nand_gate nand3(
        .a(temp_wire[0]),
        .b(temp_wire[1]),
        .y(temp_wire[2])
    );

    nand_gate nand4(
        .a(temp_wire[2]),
        .b(temp_wire[2]),
        .y(y)
    );

endmodule
module nand_gate(
    input a,
    input b,
    output y
);

    assign y = ~(a & b);

endmodule
