module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_out;

    // D flip-flop
    always_ff @(posedge clk) begin
        out <= xor_out;
    end

    // XOR gate
    assign xor_out = in ^ out;

endmodule
