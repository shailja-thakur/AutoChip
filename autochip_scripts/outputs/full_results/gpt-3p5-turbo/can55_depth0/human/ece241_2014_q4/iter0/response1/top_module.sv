module top_module (
    input clk,
    input x,
    output z
);

    reg d1, d2, d3;
    wire q1, q2, q3;

    xor #(.delay(1)) xor_gate1 (.a(x), .b(q1), .z(d1));
    and and_gate1 (.a(x), .b(~q2), .z(d2));
    or or_gate1 (.a(x), .b(~q3), .z(d3));

    d_ff d_ff1 (.clk(clk), .d(d1), .q(q1));
    d_ff d_ff2 (.clk(clk), .d(d2), .q(q2));
    d_ff d_ff3 (.clk(clk), .d(d3), .q(q3));

    xnor #(.delay(1)) xnor_gate1 (.a(q1), .b(q2), .c(q3), .z(z));

endmodule
module xor #
(
    parameter delay = 1
)
(
    input a,
    input b,
    output z
);

    wire in1;

    not not_gate1 (.a(b), .z(in1));
    and and_gate1 (.a(a), .b(in1), .z(z));

endmodule
module and (
    input a,
    input b,
    output z
);

    wire z1;

    not not_gate1 (.a(b), .z(z1));
    nand nand_gate1 (.a(a), .b(z1), .z(z));

endmodule
module or (
    input a,
    input b,
    output z
);

    wire z1;

    not not_gate1 (.a(a), .z(z1));
    nand nand_gate1 (.a(z1), .b(z1), .z(z));

endmodule
module xnor #
(
    parameter delay = 1
)
(
    input a,
    input b,
    input c,
    output z
);

    wire z1;

    xor #(.delay(delay)) xor_gate1 (.a(a), .b(b), .z(z1));
    xor xor_gate2 (.a(z1), .b(c), .z(z));

endmodule
module d_ff (
    input clk,
    input d,
    output reg q
);

    always @(posedge clk)
        q <= d;

endmodule
module not (
    input a,
    output z
);

    assign z = ~a;

endmodule
module nand (
    input a,
    input b,
    output z
);

    assign z = ~(a & b);

endmodule
