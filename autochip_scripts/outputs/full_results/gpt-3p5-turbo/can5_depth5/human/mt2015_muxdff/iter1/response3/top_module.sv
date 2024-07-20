module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    wire [2:0] q;
    wire [2:0] r; // Added wire declaration

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
        r <= r_in; // Assign r_in to r instead of q
        Q <= q[0]; // Assign q[0] to Q instead of q_in
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
