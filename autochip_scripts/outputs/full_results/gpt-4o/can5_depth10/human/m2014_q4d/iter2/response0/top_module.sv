module top_module (
    input clk,
    input in,
    output logic out
);
    wire xor_out;
    logic dff_out;

    // XOR gate
    assign xor_out = in ^ dff_out;

    // D Flip-Flop
    always @(posedge clk) begin
        dff_out <= xor_out;
        out <= dff_out;
    end
endmodule
