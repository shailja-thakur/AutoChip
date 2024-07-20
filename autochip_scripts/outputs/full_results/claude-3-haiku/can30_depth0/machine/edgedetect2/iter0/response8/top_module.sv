module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] d_last; // Register to store previous value of 'in'

always @(posedge clk) begin
    d_last <= in; // Update 'd_last' with current value of 'in'
    anyedge <= in ^ d_last; // Calculate edge detection
end

endmodule
