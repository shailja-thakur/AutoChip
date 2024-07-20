module flipflop(
    input clk,
    input D,
    output reg Q
);

always @(posedge clk) begin
    Q <= D;
end

endmodule
module mux_2_1(
    input S,
    input D0,
    input D1,
    output reg Y
);

always @(S or D0 or D1) begin
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
    output reg Q
);

wire q_mux_1, q_mux_2, q_mux_3;

mux_2_1 mux_1(.S(L), .D0(q_in), .D1(r_in), .Y(q_mux_1));
mux_2_1 mux_2(.S(L), .D0(q_mux_1), .D1(Q), .Y(q_mux_2));
mux_2_1 mux_3(.S(L), .D0(q_mux_2), .D1(q_in), .Y(q_mux_3));

flipflop ff1(.clk(clk), .D(q_mux_3), .Q(Q));

endmodule
