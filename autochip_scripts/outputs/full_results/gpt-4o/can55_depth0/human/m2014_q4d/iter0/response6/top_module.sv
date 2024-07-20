module top_module (
    input clk,
    input in,
    output logic out
);

    // Intermediate wire for the XOR output
    wire xor_out;

    // 2-input XOR gate
    assign xor_out = in ^ out;

    // D flip-flop
    always_ff @(posedge clk) begin
        out <= xor_out;
    end

endmodule
