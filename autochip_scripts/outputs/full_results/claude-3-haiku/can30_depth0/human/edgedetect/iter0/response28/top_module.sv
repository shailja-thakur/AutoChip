module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_d1; // Register to store the previous input value

always @(posedge clk) begin
    in_d1 <= in; // Store the previous input value
    pedge <= in & ~in_d1; // Detect the 0 to 1 transition and output it
end

endmodule
