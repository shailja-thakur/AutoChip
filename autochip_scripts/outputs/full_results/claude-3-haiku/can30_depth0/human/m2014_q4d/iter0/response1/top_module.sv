module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_out;

    // Instantiate the XOR gate
    assign xor_out = in ^ out;

    // Instantiate the D flip-flop
    always_ff @(posedge clk) begin
        out <= xor_out;
    end

endmodule
