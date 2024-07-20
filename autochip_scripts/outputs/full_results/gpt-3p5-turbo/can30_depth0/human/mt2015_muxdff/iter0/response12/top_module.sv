module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    wire r0, r1, r2;
    wire q0, q1, q2;
    wire q_next;

    flipflop ff1(
        .clk(clk),
        .D(q_in),
        .Q(q0)
    );

    flipflop ff2(
        .clk(clk),
        .D(q0),
        .Q(q1)
    );

    flipflop ff3(
        .clk(clk),
        .D(q1),
        .Q(q2)
    );

    mux_2to1 mux(
        .A(q1),
        .B({q2[1] ^ q2[2], q2[0], q2[2]}),
        .S(L),
        .Y(q_next)
    );

    assign Q = q_next;

endmodule
module flipflop(
    input clk,
    input D,
    output reg Q
);

    always @(posedge clk)
    begin
        Q <= D;
    end

endmodule
module mux_2to1(
    input A,
    input B,
    input S,
    output reg Y
);

    always @(A or B or S)
    begin
        if (S)
            Y <= A;
        else
            Y <= B;
    end

endmodule
