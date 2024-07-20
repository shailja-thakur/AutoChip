module top_module (
    input clk,
    input in,
    output logic out
);
    wire xor_out;
    logic q;

    // XOR gate
    assign xor_out = in ^ q;

    // D Flip-Flop
    always @(posedge clk) begin
        q <= xor_out;
    end

    assign out = q;
endmodule
