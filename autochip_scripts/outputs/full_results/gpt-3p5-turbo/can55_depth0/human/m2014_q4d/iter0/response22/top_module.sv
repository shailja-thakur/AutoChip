module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_output;    // internal signal to store the XOR result
    logic flip_flop_output;    // internal signal to store the flip-flop output

    // XOR gate implementation
    assign xor_output = in ^ flip_flop_output;

    // D flip-flop implementation
    always_ff @(posedge clk) begin
        flip_flop_output <= xor_output;
    end

    // Output assignment
    assign out = flip_flop_output;

endmodule
