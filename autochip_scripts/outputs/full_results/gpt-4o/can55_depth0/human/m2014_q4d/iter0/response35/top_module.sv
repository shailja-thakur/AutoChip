module top_module (
    input clk,
    input in,
    output reg out
);

wire xor_result;

// Two-input XOR gate feeding the D flip-flop
assign xor_result = in ^ out;

// D flip-flop, positive edge triggered
always @(posedge clk) begin
    out <= xor_result;
end

endmodule
