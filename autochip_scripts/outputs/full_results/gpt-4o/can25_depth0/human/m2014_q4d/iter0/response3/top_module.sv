module top_module (
    input clk,
    input in,
    output logic out
);
    logic xor_in;

    // XOR gate
    assign xor_in = in ^ out;

    // D flip-flop
    always_ff @(posedge clk) begin
        out <= xor_in;
    end
endmodule
