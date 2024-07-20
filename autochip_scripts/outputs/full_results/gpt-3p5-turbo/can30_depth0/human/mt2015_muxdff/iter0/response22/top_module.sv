module flipflop (
    input clk,
    input D,
    input reset,
    output reg Q
);

always @(posedge clk, posedge reset) begin
    if (reset) begin
        Q <= 1'b0;
    end else begin
        Q <= D;
    end
end

endmodule
module mux_2to1(
    input [1:0] sel,
    input D0,
    input D1,
    output reg Y
);

always @(sel, D0, D1) begin
    case (sel)
        2'b00: Y <= D0;
        2'b01: Y <= D1;
        default: Y <= D0;
    endcase
end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

wire q1;
wire q2;
wire q3;

flipflop ff1 (.clk(clk), .D(q_in), .reset(L), .Q(q1));
flipflop ff2 (.clk(clk), .D({q1, q_in}), .reset(L), .Q(q2));
flipflop ff3 (.clk(clk), .D({q1, q2}), .reset(L), .Q(q3));

mux_2to1 mux (.sel(r_in), .D0(q1), .D1(q3), .Y(Q));

endmodule
