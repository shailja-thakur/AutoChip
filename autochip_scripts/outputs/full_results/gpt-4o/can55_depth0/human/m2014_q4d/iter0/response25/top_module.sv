module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_out;  // Intermediate signal for XOR output

    // Always block for the D flip-flop
    always_ff @(posedge clk) begin
        out <= xor_out;
    end

    // Assign XOR output
    assign xor_out = in ^ out;

endmodule
