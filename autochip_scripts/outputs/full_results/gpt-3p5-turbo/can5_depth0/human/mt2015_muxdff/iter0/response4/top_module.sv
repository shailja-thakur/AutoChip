module ff_mux(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);


reg [2:0] r;
reg [2:0] q;

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q <= {q[1] ^ q[2], q[0], q[2]};
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

wire [2:0] r_0;
wire [2:0] r_1;
wire [2:0] r_2;
wire [2:0] q_0;
wire [2:0] q_1;
wire [2:0] q_2;

ff_mux u0 (
    .clk(clk),
    .L(L),
    .q_in(q_0),
    .r_in(r_0),
    .Q(Q)
);

ff_mux u1 (
    .clk(clk),
    .L(L),
    .q_in(q_1),
    .r_in(r_1),
    .Q(Q)
);

ff_mux u2 (
    .clk(clk),
    .L(L),
    .q_in(q_2),
    .r_in(r_2),
    .Q(Q)
);

assign r_0 = r_in;
assign r_1 = r_in;
assign r_2 = r_in;

assign q_0 = q_in;
assign q_1 = q_in;
assign q_2 = q_in;

endmodule
