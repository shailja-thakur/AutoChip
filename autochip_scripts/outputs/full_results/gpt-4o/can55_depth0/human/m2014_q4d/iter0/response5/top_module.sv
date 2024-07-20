module top_module (
    input clk,
    input in,
    output logic out
);
    // Intermediate wire to hold the XOR result
    wire xor_result;

    // XOR gate: takes 'in' and 'out' as inputs
    assign xor_result = in ^ out;

    // D flip-flop: triggered on the positive edge of 'clk'
    always_ff @(posedge clk) begin
        out <= xor_result;
    end

endmodule
