module top_module (
    input clk,
    input in,
    output reg out
);

    wire xor_out;

    assign xor_out = in ^ out;

    always @(posedge clk) begin
        out <= xor_out;
    end

endmodule
