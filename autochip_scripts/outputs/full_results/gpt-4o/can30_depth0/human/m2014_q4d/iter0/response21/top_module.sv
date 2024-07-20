module top_module (
	input clk,
	input in,
	output logic out
);
    logic d;

    assign d = in ^ out;

    always_ff @(posedge clk) begin
        out <= d;
    end
endmodule
