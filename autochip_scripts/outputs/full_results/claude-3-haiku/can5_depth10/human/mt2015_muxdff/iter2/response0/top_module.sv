module full_module (
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

wire [2:0] q_wire;

top_module top_module_inst0 (
    .clk(clk),
    .L(L),
    .q_in(q_wire[0]),
    .r_in(r[0]),
    .Q(q_wire[0])
);

top_module top_module_inst1 (
    .clk(clk),
    .L(L),
    .q_in(q_wire[1]),
    .r_in(r[1]),
    .Q(q_wire[1])
);

top_module top_module_inst2 (
    .clk(clk),
    .L(L),
    .q_in(q_wire[2]),
    .r_in(r[2]),
    .Q(q_wire[2])
);

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q <= {q_wire[1] ^ q_wire[2], q_wire[0], q_wire[2]};
    end
end

endmodule
module top_module (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= q_in;
    end
end

endmodule
