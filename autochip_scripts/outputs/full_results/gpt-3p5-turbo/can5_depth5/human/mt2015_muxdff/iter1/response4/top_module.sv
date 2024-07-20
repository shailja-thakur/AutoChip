module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    reg [2:0] r;
    wire [2:0] q;

    // Create submodule instances
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

    multiplexer U3(
        .A(q[1]),
        .B(r_in),
        .S(L),
        .Z(q[2])
    );

    always @(posedge clk) begin
        if (L) begin
            r <= r_in;
            Q <= q_in;
        end else begin
            r <= q[1] ^ q[2];
            Q <= q[2];
        end
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
    output Z
);

    assign Z = (S == 1'b0) ? A : B;

endmodule
