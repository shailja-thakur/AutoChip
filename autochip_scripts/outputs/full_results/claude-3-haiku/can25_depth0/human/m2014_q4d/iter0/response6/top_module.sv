module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_output;

    // Implement the XOR logic
    assign xor_output = in ^ out;

    // Implement the D flip-flop
    always_ff @(posedge clk) begin
        out <= xor_output;
    end

endmodule
