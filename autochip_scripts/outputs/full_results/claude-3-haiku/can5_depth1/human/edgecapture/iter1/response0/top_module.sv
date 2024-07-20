module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

always @(posedge clk) begin
    if (reset) begin
        out <= 32'b0;
    end
    else begin
        out <= (out | (~in & in_prev)); // Capture when input changes from 1 to 0
        in_prev <= in; // Update the previous input value
    end
end

reg [31:0] in_prev; // Register to hold previous input value

endmodule
