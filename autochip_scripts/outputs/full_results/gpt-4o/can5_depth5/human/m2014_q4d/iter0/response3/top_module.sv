module top_module (
    input clk,
    input in,
    output logic out
);

    wire xor_out;

    // XORing the input 'in' and the current output 'out' of the flip-flop
    assign xor_out = in ^ out;
    
    // Positive edge-triggered D flip-flop
    always_ff @(posedge clk) begin
        out <= xor_out;
    end
    
endmodule
