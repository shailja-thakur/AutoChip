module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_prev; // Register to store previous input

always @(posedge clk) begin
    in_prev <= in; // Store previous input
    pedge <= in & ~in_prev; // Detect 0 to 1 transitions
end

endmodule
