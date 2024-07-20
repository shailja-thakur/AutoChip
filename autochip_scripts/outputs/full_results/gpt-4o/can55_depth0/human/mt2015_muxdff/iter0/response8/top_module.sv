module dff_mux (
    input clk,
    input L,
    input D,
    input M,
    output reg Q
);
    always @(posedge clk) begin
        if (L)
            Q <= D;
        else
            Q <= M;
    end
endmodule
module top_module (
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire q0, q1, q2;

    dff_mux u0 (.clk(clk), .L(L), .D(r[0]), .M(q1 ^ q2), .Q(q0));
    dff_mux u1 (.clk(clk), .L(L), .D(r[1]), .M(q0), .Q(q1));
    dff_mux u2 (.clk(clk), .L(L), .D(r[2]), .M(q2), .Q(q2));

    assign q = {q2, q1, q0};
endmodule
