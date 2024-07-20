module top_module (
    input clk,
    input in,
    output reg out
);
    wire xor_out;
    reg d_ff_out;
    
    // XOR gate
    assign xor_out = in ^ d_ff_out;

    // D Flip-Flop
    always @(posedge clk) begin
        d_ff_out <= xor_out;
    end

    // Output assignment
    assign out = d_ff_out;
    
endmodule
