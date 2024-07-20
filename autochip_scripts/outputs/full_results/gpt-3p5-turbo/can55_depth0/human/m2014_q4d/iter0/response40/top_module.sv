module top_module (
	input clk,
	input in,
	output logic out
);

    logic d_ff_out;
    logic xor_out;

    assign xor_out = in ^ out; 

    always @(posedge clk) begin
        d_ff_out <= xor_out;
    end

    assign out = d_ff_out;

endmodule
