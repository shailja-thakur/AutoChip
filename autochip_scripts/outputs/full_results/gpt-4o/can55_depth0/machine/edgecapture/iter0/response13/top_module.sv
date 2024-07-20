module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] d_last;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 0;
            d_last <= 0;
        end else begin
            // Store the current input value in d_last
            d_last <= in;
            // Assign out the value of out ORed with the NOT of the input ANDed with d_last
            out <= out | (~in & d_last);
        end
    end
endmodule
