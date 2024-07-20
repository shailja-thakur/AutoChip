module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_prev;

always @(posedge clk) begin
    // Store the previous input value
    in_prev <= in;

    // Detect the 0 to 1 transition and set the corresponding output bit
    pedge <= in & ~in_prev;
end

endmodule
