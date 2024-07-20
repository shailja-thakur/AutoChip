module flipflop(
    input clk,
    input R,
    output reg Q);

    always @(posedge clk) begin
        if (R) begin
            Q <= 0;
        end else begin
            Q <= 1;
        end
    end
endmodule
module mux2to1(
    input S,
    input D0,
    input D1,
    output reg Y);

    always @(S, D0, D1) begin
        if (S) begin
            Y <= D1;
        end else begin
            Y <= D0;
        end
    end
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    wire r;
    wire q;

    assign r = r_in;
    assign q = q_in;

    flipflop flipflop1(.clk(clk), .R(L), .Q(q));
    flipflop flipflop2(.clk(clk), .R(L), .Q(q));
    flipflop flipflop3(.clk(clk), .R(L), .Q(q));

    mux2to1 mux(.S(L), .D0(q), .D1(r), .Y(Q));
endmodule
