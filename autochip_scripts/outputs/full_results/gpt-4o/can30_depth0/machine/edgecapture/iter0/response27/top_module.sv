module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
    reg [31:0] d_last;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 0; // Reset the output to 0
            d_last <= 0; // Reset the previous input value to 0
        end else begin
            d_last <= in; // Store the current input as the previous value
            out <= out | (~in & d_last); // Update the output value
        end
    end
endmodule
