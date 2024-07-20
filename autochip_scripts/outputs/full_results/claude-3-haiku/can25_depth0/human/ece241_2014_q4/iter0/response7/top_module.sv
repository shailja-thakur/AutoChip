module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] state;

wire xor_out;
wire and_out;
wire or_out;

always @(posedge clk) begin
    state <= {state[1:0], x};
end

assign xor_out = x ^ state[0];
assign and_out = x & ~state[0];
assign or_out = x | ~state[0];

assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
