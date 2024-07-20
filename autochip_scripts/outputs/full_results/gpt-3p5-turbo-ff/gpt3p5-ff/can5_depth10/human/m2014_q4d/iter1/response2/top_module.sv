module top_module (
    input clk,
    input in,
    output reg out
);

// reg type is used for flip-flop D input
reg d;

always @(posedge clk) begin
    d <= in ^ out; // D flip-flop input
    out <= d; // D flip-flop output
end

endmodule
