module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_out;

    // two-input XOR gate
    assign xor_out = in ^ out;

    // positive edge-triggered D flip-flop
    always_ff @(posedge clk) begin
        out <= xor_out;
    end

endmodule
