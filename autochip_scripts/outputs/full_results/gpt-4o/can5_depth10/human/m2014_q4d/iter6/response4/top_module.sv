module top_module (
    input clk,
    input in,
    output reg out
);
    wire xor_out;
    reg out_next;

    // XOR gate
    assign xor_out = in ^ out;

    // D Flip-Flop
    always @(posedge clk) begin
        out <= xor_out;
    end
endmodule
