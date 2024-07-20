module full_module (
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

wire [2:0] q_internal;

dff_mux inst0 (
    .clk(clk),
    .L(L),
    .q_in(q[1]),
    .r_in(r[0]),
    .q_out(q_internal[0])
);

dff_mux inst1 (
    .clk(clk),
    .L(L),
    .q_in(q[2]),
    .r_in(r[1]),
    .q_out(q_internal[1])
);

dff_mux inst2 (
    .clk(clk),
    .L(L),
    .q_in(q[0]),
    .r_in(r[2]),
    .q_out(q_internal[2])
);

always @(posedge clk) begin
    q <= q_internal;
end

endmodule
module dff_mux(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg q_out
);

always @(posedge clk) begin
    if (L) begin
        q_out <= r_in;
    end else begin
        q_out <= q_in;
    end
end

endmodule
