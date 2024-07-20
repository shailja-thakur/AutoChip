module flipflop(
    input clk,
    input D,
    output reg Q
);

always @(posedge clk)
    Q <= D;

endmodule
module two_to_one_mux(
    input [2:0] sel,
    input [2:0] D0,
    input [2:0] D1,
    input [2:0] D2,
    output [2:0] Y
);

assign Y = (sel == 0) ? D0 :
           (sel == 1) ? D1 :
           (sel == 2) ? D2 :
           3'b000;

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

reg [2:0] r1, r2, r3;
wire [2:0] q1, q2, q3;

flipflop ff1 (
    .clk(clk),
    .D(r_in),
    .Q(q1)
);

two_to_one_mux mux1 (
    .sel({q1[1] ^ q1[2], q1[0], q1[2]}),
    .D0(q_in),
    .D1(q2),
    .D2(q3),
    .Y(r1)
);

flipflop ff2 (
    .clk(clk),
    .D(r1),
    .Q(q2)
);

two_to_one_mux mux2 (
    .sel({q2[1] ^ q2[2], q2[0], q2[2]}),
    .D0(q_in),
    .D1(q1),
    .D2(q3),
    .Y(r2)
);

flipflop ff3 (
    .clk(clk),
    .D(r2),
    .Q(q3)
);

two_to_one_mux mux3 (
    .sel({q3[1] ^ q3[2], q3[0], q3[2]}),
    .D0(q_in),
    .D1(q1),
    .D2(q2),
    .Y(r3)
);

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= r3;
    end
end

endmodule
