module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg c;

// Sequential logic to update register c
always @(posedge clk) begin
    c <= (a & b) | (a & c) | (b & c);
end

// Combinational logic to calculate outputs q and state
always @(*) begin
    q = a ^ b ^ c;
    state = c;
end

endmodule
