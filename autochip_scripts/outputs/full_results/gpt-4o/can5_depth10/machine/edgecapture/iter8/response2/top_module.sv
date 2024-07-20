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
        d_last <= in; // Store current input in d_last
        out <= out | (~in & d_last); // Update output as specified
    end
end

endmodule
