module flipflop (
    input clk,
    input R,
    output reg Q
);
    always @(posedge clk) begin
        if (R) begin
            Q <= 1'b0;
        end else begin
            Q <= 1'b1;
        end
    end
endmodule
module mux (
    input a,
    input b,
    input sel,
    output reg out
);
    always @(a or b or sel) begin
        if (sel) begin
            out <= b;
        end else begin
            out <= a;
        end
    end
endmodule
module top_module (
    input clk,
    input L,
    input r_in,
    output reg Q
);
    wire q1, q2, q3;

    flipflop ff1 (
        .clk(clk),
        .R(r_in),
        .Q(q1)
    );

    flipflop ff2 (
        .clk(clk),
        .R(L),
        .Q(q2)
    );

    mux m1 (
        .a(q1),
        .b(q2),
        .sel(L),
        .out(q3)
    );

    flipflop ff3 (
        .clk(clk),
        .R(L),
        .Q(Q)
    );
endmodule
