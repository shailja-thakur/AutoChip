module flipflop(
    input clk,
    input D,
    input rst,
    output reg Q
);
    always @(posedge clk or posedge rst)
    begin
        if (rst)
            Q <= 1'b0;
        else
            Q <= D;
    end
endmodule
module mux_2to1(
    input S,
    input I0,
    input I1,
    output reg O
);
    always @(*)
    begin
        case (S)
            1'b0: O = I0;
            1'b1: O = I1;
        endcase
    end
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    wire q0, q1, q2;
    wire d0, d1, d2;
    wire s0, s1, s2;

    flipflop FF0 (
        .clk(clk),
        .D(d0),
        .rst(~L),
        .Q(q0)
    );

    flipflop FF1 (
        .clk(clk),
        .D(d1),
        .rst(~L),
        .Q(q1)
    );

    flipflop FF2 (
        .clk(clk),
        .D(d2),
        .rst(~L),
        .Q(q2)
    );

    mux_2to1 MUX0 (
        .S(s0),
        .I0(q0),
        .I1(r_in),
        .O(d0)
    );

    mux_2to1 MUX1 (
        .S(s1),
        .I0(q1),
        .I1(r_in),
        .O(d1)
    );

    mux_2to1 MUX2 (
        .S(s2),
        .I0(q2),
        .I1(r_in),
        .O(d2)
    );

    always @(posedge clk)
    begin
        s0 <= q_in[1] ^ q_in[2];
        s1 <= q_in[0];
        s2 <= q_in[2];

        if (L)
        begin
            Q <= r_in;
        end
        else
        begin
            Q <= {q_in[1] ^ q_in[2], q_in[0], q_in[2]};
        end
    end
endmodule
