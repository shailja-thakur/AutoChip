module flipflop (
    input clk,
    input [2:0] r,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q <= {q[1] ^ q[2], q[0], q[2]};
    end
end

endmodule
module mux_2to1 (
    input [2:0] a,
    input [2:0] b,
    input sel,
    output [2:0] y
);

assign y = sel ? b : a;

endmodule
module top_module (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

wire [2:0] q;
wire [2:0] r;
wire [2:0] a;
wire [2:0] b;
wire sel;

assign r = r_in;
assign a = q_in;
assign b = q;
assign sel = L;

flipflop ff1 (
    .clk(clk),
    .r(r),
    .q(q)
);

flipflop ff2 (
    .clk(clk),
    .r(r),
    .q(q)
);

flipflop ff3 (
    .clk(clk),
    .r(r),
    .q(q)
);

mux_2to1 mux (
    .a(a),
    .b(b),
    .sel(sel),
    .y(Q)
);

endmodule
