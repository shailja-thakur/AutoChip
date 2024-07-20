module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_out;
    
    // Two-input XOR gate: inputs are 'in' and 'out'
    assign xor_out = in ^ out;
    
    // D Flip-Flop with positive edge triggering
    always_ff @(posedge clk) begin
        out <= xor_out;
    end

endmodule
