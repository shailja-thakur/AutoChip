module top_module (
	input clk,
	input in,
	output logic out
);
    logic out_reg;

    always_ff @(posedge clk) begin
        out_reg <= in ^ out_reg;
    end

    always_comb begin
        out = out_reg;
    end
endmodule
