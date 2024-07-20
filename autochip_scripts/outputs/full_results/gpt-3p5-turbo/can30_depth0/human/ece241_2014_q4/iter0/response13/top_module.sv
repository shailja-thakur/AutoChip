module top_module(
    input  clk,
    input  x,
    output z
);

/* Flip Flop */
reg [2:0] flip_flop;
always @(posedge clk)
begin
    flip_flop <= {flip_flop[1:0], x};
end

/* XOR gate */
wire xor_out;
assign xor_out = flip_flop[1] ^ flip_flop[0];

/* AND gate */
wire and_out;
assign and_out = flip_flop[1] & ~flip_flop[0];

/* OR gate */
wire or_out;
assign or_out = flip_flop[1] | ~flip_flop[0];

/* XNOR gate */
assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
