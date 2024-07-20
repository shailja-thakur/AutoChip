module top_module (
    input clk,
    input in,
    output logic out
);

    logic d_in;

    // XOR gate
    assign d_in = in ^ out;

    // D Flip-Flop
    always_ff @(posedge clk) begin
        out <= d_in;
    end

endmodule
