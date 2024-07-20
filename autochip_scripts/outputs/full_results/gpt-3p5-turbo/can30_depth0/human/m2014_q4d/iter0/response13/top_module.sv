module top_module (
    input clk,
    input in,
    output logic out
);

reg d;

assign out = d;

always @(posedge clk) begin
    d <= in ^ out;
end

endmodule
