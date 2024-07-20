module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_output;

    // XOR gate
    assign xor_output = in ^ out;

    // D flip-flop
    always_ff @(posedge clk) begin
        out <= xor_output;
    end

endmodule
