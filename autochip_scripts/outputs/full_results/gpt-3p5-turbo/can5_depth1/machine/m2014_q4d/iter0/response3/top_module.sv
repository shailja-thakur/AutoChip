module top_module (
    input clk,
    input in,
    output logic out
);

logic out_reg;

always_ff @(posedge clk) begin
    out_reg <= in ^ out_reg;
end

assign out = out_reg;

endmodule
