module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_d; // Delayed input for edge detection

always @(posedge clk) begin
    in_d <= in; // Store the previous input
    pedge <= (in & ~in_d); // Detect the 0 to 1 transition
end

endmodule
