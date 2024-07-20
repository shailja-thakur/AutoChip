module top_module (
    input clk,
    input L,
    input r_in,
    output reg q_in,
    output reg Q
);

reg [2:0] r;
reg [2:0] q_out;

sub_module sub1(
    .clk(clk),
    .L(L),
    .q_in(q_out[0]),
    .r_in(r[0]),
    .Q());
    
sub_module sub2(
    .clk(clk),
    .L(L),
    .q_in(q_out[1]),
    .r_in(r[1]),
    .Q());
    
sub_module sub3(
    .clk(clk),
    .L(L),
    .q_in(q_out[2]),
    .r_in(r[2]),
    .Q());

always @(posedge clk) begin
    r[0] <= r_in[0];
    r[1] <= r_in[1];
    r[2] <= r_in[2];
    
    q_in <= q_out;
    
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= {q_out[1] ^ q_out[2], q_out[0], q_out[2]};
    end
end

endmodule
module sub_module(
    input clk,
    input L,
    input r_in,
    output reg q_in,
    output reg Q
);

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= {q_in[1] ^ q_in[2], q_in[0], q_in[2]};
    end
end

endmodule
