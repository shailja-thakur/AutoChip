module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_out;
    logic out_reg;

    // XOR gate
    assign xor_out = in ^ out_reg;

    // D flip-flop
    always_ff @(posedge clk) begin
        out_reg <= xor_out;
    end

    // Output assignment
    assign out = out_reg;

endmodule
