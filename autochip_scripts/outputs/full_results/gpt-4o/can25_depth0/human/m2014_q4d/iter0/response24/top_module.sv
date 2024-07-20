module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_result;

    // XOR gate
    assign xor_result = in ^ out;

    // D Flip-Flop
    always_ff @(posedge clk) begin
        out <= xor_result;
    end

endmodule
