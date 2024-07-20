module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_ff1; // First FF to capture input

always @(posedge clk) begin
    in_ff1 <= in; // Store previous input value
    pedge <= in & ~in_ff1; // Detect 0 to 1 transition
end

endmodule
