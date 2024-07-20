module top_module (
    input clk,
    input in,
    output logic out
);

    wire d;

    // XOR gate
    assign d = in ^ out;

    // D flip-flop
    always_ff @(posedge clk) begin
        out <= d;
    end

endmodule
