module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

// Register to store the previous value of 'in'
reg [7:0] d_last;

always @(posedge clk) begin
    d_last <= in; // Update d_last with the current value of 'in'
    anyedge <= in ^ d_last; // Exclusive-OR operation to detect any edge
end

endmodule
