module top_module (
    input clk,
    input x,
    output reg z
);

reg [2:0] flip_flop_outputs;
wire d1, d2, d3;

assign d1 = x ^ flip_flop_outputs[0];
assign d2 = ~flip_flop_outputs[1];
assign d3 = ~flip_flop_outputs[2];

always@(posedge clk) begin
    flip_flop_outputs <= {d1, d2, d3};
    z <= ~(d1 ^ d2 ^ d3);
end

endmodule
