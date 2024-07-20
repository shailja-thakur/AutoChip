module top_module (
    input clk,
    input in,
    output logic out
);
    wire xor_out;
    logic temp_out;

    // XOR gate
    assign xor_out = in ^ temp_out;

    // D Flip-Flop
    always_ff @(posedge clk) begin
        temp_out <= xor_out;
    end

    assign out = temp_out;
endmodule
