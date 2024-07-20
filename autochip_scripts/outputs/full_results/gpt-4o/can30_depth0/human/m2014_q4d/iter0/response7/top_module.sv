module top_module (
    input clk,
    input in,
    output logic out
);

    logic d; // Internal wire for the D input of the flip-flop

    // XOR gate
    assign d = in ^ out;

    // D flip-flop, positive edge triggered
    always_ff @(posedge clk) begin
        out <= d;
    end

endmodule
