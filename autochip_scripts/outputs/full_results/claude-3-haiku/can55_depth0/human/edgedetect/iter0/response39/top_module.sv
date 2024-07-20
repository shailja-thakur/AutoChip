module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_prev; // Store the previous input value

always @(posedge clk) begin
    in_prev <= in; // Store the current input value in the previous input register
    
    // Detect the 0 to 1 transition for each bit and set the corresponding output bit
    pedge <= in & ~in_prev;
end

endmodule
