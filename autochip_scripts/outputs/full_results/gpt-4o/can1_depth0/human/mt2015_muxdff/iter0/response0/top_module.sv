module submodule(
    input clk,
    input L,
    input D,
    input r_in, // direct input when L is high
    output reg Q
);
    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= D;
        end
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire [2:0] D;
    
    assign D[0] = q[1] ^ q[2];
    assign D[1] = q[0];
    assign D[2] = q[2];

    submodule u0 (
        .clk(clk),
        .L(L),
        .D(D[0]),
        .r_in(r[0]),
        .Q(q[0])
    );

    submodule u1 (
        .clk(clk),
        .L(L),
        .D(D[1]),
        .r_in(r[1]),
        .Q(q[1])
    );

    submodule u2 (
        .clk(clk),
        .L(L),
        .D(D[2]),
        .r_in(r[2]),
        .Q(q[2])
    );
endmodule
