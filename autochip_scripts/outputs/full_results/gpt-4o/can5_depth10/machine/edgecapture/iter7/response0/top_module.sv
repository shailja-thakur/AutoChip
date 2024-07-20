module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

reg [31:0] d_last;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        out <= 0;
        d_last <= 0;
    end else begin
        d_last <= in;                   // Moved storing the input to 'd_last' before calculating 'out'
        out <= out | (~in & d_last);    // Changed to use the new 'in' value and the previous 'd_last' value correctly
    end
end

endmodule
