module top_module (
	input clk,
	input in,
	output logic out
);

    logic d_ff; // Flip-flop output signal
    logic xor_out; // XOR output signal
    
    // Define XOR gate
    assign xor_out = in ^ out;
    
    // Define positive edge-triggered D flip-flop
    always @(posedge clk) begin
        d_ff <= xor_out;
    end
    
    // Output of the flip-flop
    assign out = d_ff;
    
endmodule
