module top_module (
    input clk,
    input in,
    output logic out
);

    wire xor_out;
    logic ff_out;  // Internal signal for flip-flop output

    // XOR gate
    assign xor_out = in ^ ff_out;

    // D flip-flop
    always_ff @(posedge clk) begin
        ff_out <= xor_out;
    end

    // Assign internal flip-flop output to module output
    assign out = ff_out;

endmodule
