module top_module (
    input clk,
    input in,
    output reg out
);
    reg xor_ff_out;

    // XOR gate
    wire xor_out = in ^ xor_ff_out;

    // D Flip-Flop
    always @(posedge clk) begin
        xor_ff_out <= xor_out;
    end

    // Assign the output to the XOR flip-flop output
    assign out = xor_ff_out;

endmodule
