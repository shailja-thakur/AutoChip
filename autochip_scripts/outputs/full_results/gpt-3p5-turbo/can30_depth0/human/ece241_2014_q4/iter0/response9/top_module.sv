module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] flip_flops;
wire xor_input, and_input, or_input;

assign xor_input = x ^ flip_flops[2];
assign and_input = x & ~flip_flops[1];
assign or_input = x | ~flip_flops[0];

always @(posedge clk) begin
    flip_flops <= {xor_input, and_input, or_input};
end

assign z = ~(flip_flops[0] ^ flip_flops[1] ^ flip_flops[2]);

endmodule
