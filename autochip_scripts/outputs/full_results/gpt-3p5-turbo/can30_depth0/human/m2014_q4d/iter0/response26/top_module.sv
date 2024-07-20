module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_output;
    logic d_ff_input;

    // XOR gate
    assign xor_output = in ^ out;

    // D flip-flop
    always_ff @(posedge clk) begin
        d_ff_input <= xor_output;
        out <= d_ff_input;
    end

endmodule
