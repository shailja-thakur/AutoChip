module sub_module (
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
module top_module (
    input clk,
    input [2:0] r,
    input L,
    output [2:0] Q
);

wire [2:0] mux_out;

// Instantiate the submodules
sub_module sub0 (
    .clk(clk),
    .L(L),
    .q_in(Q[1] ^ Q[2]),
    .r_in(r[0]),
    .q_out(mux_out[0])
);

sub_module sub1 (
    .clk(clk),
    .L(L),
    .q_in(Q[0]),
    .r_in(r[1]),
    .q_out(mux_out[1])
);

sub_module sub2 (
    .clk(clk),
    .L(L),
    .q_in(Q[2]),
    .r_in(r[2]),
    .q_out(mux_out[2])
);

// Register assignments for the output Q
always @(posedge clk) begin
    if (L) begin
        Q <= r;
    end else begin
        Q <= mux_out;
    end
end

endmodule
