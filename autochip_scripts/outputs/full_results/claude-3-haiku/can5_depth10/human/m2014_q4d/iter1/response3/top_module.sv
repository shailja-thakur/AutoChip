module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_out;

    // XOR gate
    assign xor_out = in ^ out;

    // D flip-flop
    always_ff @(posedge clk) begin
        out <= xor_out;
    end

    // Initialize the output signal
    initial begin
        out = 0;
    end

endmodule
