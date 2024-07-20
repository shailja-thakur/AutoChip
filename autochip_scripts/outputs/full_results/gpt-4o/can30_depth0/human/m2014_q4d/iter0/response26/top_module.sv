module top_module (
    input clk,
    input in,
    output logic out
);

    logic d;

    // XOR gate
    assign d = in ^ out;

    // D Flip-Flop
    always_ff @(posedge clk) begin
        out <= d;
    end

endmodule
