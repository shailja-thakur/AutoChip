module top_module (
    input clk,
    input in,
    output reg out
);
    wire xor_out;
    reg d;

    // XOR gate
    assign xor_out = in ^ out;

    // D Flip-Flop
    always @(posedge clk) begin
        d <= xor_out;
        out <= d;
    end
endmodule
