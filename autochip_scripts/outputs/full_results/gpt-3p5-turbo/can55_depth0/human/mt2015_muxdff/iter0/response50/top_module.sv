module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

reg [2:0] q;

submodule1 submodule1_inst(.clk(clk), .L(L), .q_in(q_in), .r_in(r_in), .Q(Q));

endmodule
module submodule1(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

reg [2:0] q;

always @(posedge clk) begin
    if (L) begin
        q <= r_in;
    end else begin
        q <= {q_in[1] ^ q_in[2], q_in[0], q_in[2]};
    end
end

endmodule
