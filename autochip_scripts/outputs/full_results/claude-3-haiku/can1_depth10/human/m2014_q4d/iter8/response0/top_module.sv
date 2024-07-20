module top_module (
    input clk,
    input in,
    output logic out
);

    xor_dff my_xor_dff (
        .clk(clk),
        .in(in),
        .out(out)
    );

endmodule
module xor_dff (
    input clk,
    input in,
    output logic out
);

    logic xor_out;

    // XOR gate
    assign xor_out = in ^ out;

    // D flip-flop
    always_ff @(posedge clk) begin
        out <= xor_out;
    end

endmodule
