module top_module (
    input clk,
    input in,
    output reg out
);
    reg xor_out;

    // XOR gate with the initial value of out
    initial out = 0;

    always @(posedge clk) begin
        xor_out = in ^ out;
        out <= xor_out;
    end
endmodule
