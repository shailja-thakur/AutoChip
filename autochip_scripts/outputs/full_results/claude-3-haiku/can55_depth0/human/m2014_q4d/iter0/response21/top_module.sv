module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_out;

    // Implement the XOR logic
    assign xor_out = in ^ out;

    // Implement the D flip-flop
    always_ff @(posedge clk) begin
        out <= xor_out;
    end

endmodule
