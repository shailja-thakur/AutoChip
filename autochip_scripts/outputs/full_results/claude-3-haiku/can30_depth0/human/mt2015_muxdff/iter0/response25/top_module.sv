module top_module(
    input clk,
    input L,
    input [2:0] q_in,
    input [2:0] r_in,
    output reg [2:0] Q
);

wire [2:0] q_out;

top_module u0(.clk(clk), .L(L), .q_in(q_in[0]), .r_in(r_in[0]), .Q(q_out[0]));
top_module u1(.clk(clk), .L(L), .q_in(q_in[1]), .r_in(r_in[1]), .Q(q_out[1]));
top_module u2(.clk(clk), .L(L), .q_in(q_in[2]), .r_in(r_in[2]), .Q(q_out[2]));

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= {q_out[1] ^ q_out[2], q_out[0], q_out[2]};
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

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= q_in;
    end
end

endmodule
