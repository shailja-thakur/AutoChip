module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] in_prev;

always @(posedge clk) begin
    // Store the previous input value
    in_prev <= in;
    
    // Check for any edge transitions and set the output
    anyedge <= in ^ in_prev;
end

endmodule
