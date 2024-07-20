module sub_module (
    input clk,
    input L,
    input D,
    input M,
    output reg Q
);
    always @(posedge clk) begin
        if (L) begin
            Q <= D;
        end else begin
            Q <= M;
        end
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r_in,
    input [2:0] q_in,
    output [2:0] Q
);
    wire [2:0] M;

    // Assign the values for M
    assign M[2] = q_in[1] ^ q_in[2];
    assign M[1] = q_in[0];
    assign M[0] = q_in[2];

    // Instantiate three sub_modules
    sub_module u0 (
        .clk(clk),
        .L(L),
        .D(r_in[0]),
        .M(M[0]),
        .Q(Q[0])
    );

    sub_module u1 (
        .clk(clk),
        .L(L),
        .D(r_in[1]),
        .M(M[1]),
        .Q(Q[1])
    );

    sub_module u2 (
        .clk(clk),
        .L(L),
        .D(r_in[2]),
        .M(M[2]),
        .Q(Q[2])
    );
endmodule
