module top_module (
    input clk,
    input x,
    output z
);

reg d_ff_1, d_ff_2, d_ff_3;
wire xff_1, xff_2, xff_3;

assign xff_1 = x ^ d_ff_1;
assign xff_2 = ~d_ff_2;
assign xff_3 = ~d_ff_3;

assign z = xff_1 ^ xff_2 ^ xff_3;

always @(posedge clk) begin
    d_ff_1 <= x;
    d_ff_2 <= d_ff_1;
    d_ff_3 <= ~d_ff_1;
end

endmodule
