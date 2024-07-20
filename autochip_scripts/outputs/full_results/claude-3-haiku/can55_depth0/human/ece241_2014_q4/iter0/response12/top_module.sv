module top_module (
    input clk,
    input x,
    output z
);

reg q1, q2, q3;

wire xor_out, and_out, or_out;

assign xor_out = x ^ q1;
assign and_out = x & ~q2;
assign or_out = x | ~q3;

always @(posedge clk) begin
    q1 <= xor_out;
    q2 <= and_out;
    q3 <= or_out;
end

assign z = ~(q1 ^ q2 ^ q3);

endmodule
