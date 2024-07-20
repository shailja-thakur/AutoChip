module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    reg [2:0] r;
    reg [2:0] q;

    flipflop U1(
        .clk(clk),
        .D(q_in),
        .Q(q[0])
    );

    flipflop U2(
        .clk(clk),
        .D(q[2]),
        .Q(q[1])
    );

    flipflop U3(
        .clk(clk),
        .D(q[1] ^ q[2]),
        .Q(q[2])
    );

    multiplexer U4(
        .A(q[1]),
        .B(r_in),
        .S(L),
        .Z(r[2])
    );

    always @(posedge clk) begin
        r <= {r[1:0], r_in};
        Q <= q[0];
    end

endmodule
module flipflop(
    input clk,
    input D,
    output reg Q
);

    always @(posedge clk) begin
        Q <= D;
    end

endmodule
module multiplexer(
    input A,
    input B,
    input S,
    output reg Z
);

    always @(A or B or S) begin
        if (S == 0)
            Z <= A;
        else
            Z <= B;
    end

endmodule
