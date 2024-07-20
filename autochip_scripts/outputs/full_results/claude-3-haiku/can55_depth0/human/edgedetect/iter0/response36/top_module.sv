module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_prev; // Store the previous input value

always @(posedge clk) begin
    // Check for 0 to 1 transition on each bit
    pedge <= in & ~in_prev;
    in_prev <= in; // Update the previous input value
end

endmodule
