module top_module (
    input wire clk,
    input wire in,
    output wire out
);
    reg out_reg;

    always @(posedge clk)
    begin
        out_reg <= in ^ out_reg;
        out <= out_reg;
    end
endmodule
