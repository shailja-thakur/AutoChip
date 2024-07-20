module top_module (
	input clk,
	input in,
	output logic out
);

    logic xor_out;
    
    // XOR gate takes the input 'in' and the current 'out' of the flip-flop
    assign xor_out = in ^ out;

    // D flip-flop, positive edge triggered by clk
    always_ff @(posedge clk) begin
        out <= xor_out;
    end

endmodule
