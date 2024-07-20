module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] flip_flop_out;
wire xnor_in[2:0];

assign xnor_in[0] = flip_flop_out[0];
assign xnor_in[1] = ~flip_flop_out[1];
assign xnor_in[2] = ~flip_flop_out[2];

assign z = ~(xnor_in[0] ^ xnor_in[1] ^ xnor_in[2]);

always @(posedge clk) begin
    flip_flop_out <= {flip_flop_out[1:0], x};
end

endmodule
