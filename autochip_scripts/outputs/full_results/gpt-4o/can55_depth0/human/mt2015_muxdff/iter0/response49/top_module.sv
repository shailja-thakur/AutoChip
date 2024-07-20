module submodule(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_in;
        end
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire [2:0] q_intermediate;
    
    submodule u0 (
        .clk(clk),
        .L(L),
        .q_in(q_intermediate[2] ^ q_intermediate[1]),
        .r_in(r[0]),
        .Q(q_intermediate[0])
    );
    
    submodule u1 (
        .clk(clk),
        .L(L),
        .q_in(q_intermediate[0]),
        .r_in(r[1]),
        .Q(q_intermediate[1])
    );
    
    submodule u2 (
        .clk(clk),
        .L(L),
        .q_in(q_intermediate[2]),
        .r_in(r[2]),
        .Q(q_intermediate[2])
    );

    assign q = q_intermediate;
endmodule
