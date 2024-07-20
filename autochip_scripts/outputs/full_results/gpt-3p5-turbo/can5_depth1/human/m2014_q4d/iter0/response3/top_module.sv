module top_module (
	input clk,
	input in,
	output logic out
);

    logic xor_output;
    logic d_input;
    
    assign xor_output = in ^ out;
    always_ff @(posedge clk) begin
        d_input <= xor_output;
        out <= d_input;
    end
    
endmodule
