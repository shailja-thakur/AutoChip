module flipflop (
    input clk,
    input D,
    output reg Q
);

always @(posedge clk)
    Q <= D;

endmodule
module mux2to1 (
    input S,
    input D0,
    input D1,
    output reg Y
);

always @(S or D0 or D1) begin
    case (S)
        0: Y <= D0;
        1: Y <= D1;
    endcase
end

endmodule
module top_module (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

reg f1_q, f2_q, f3_q;

always @(posedge clk) begin
    f1_q <= q_in;
    f2_q <= f1_q;
    f3_q <= f2_q;
    Q <= f3_q;
end

wire mux_output;

mux2to1 mux (
    .S(L),
    .D0(r_in),
    .D1(Q),
    .Y(mux_output)
);

always @(*) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= mux_output;
    end
end

endmodule
