module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] d_last;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 32'b0;
            d_last <= 32'b0;
        end else begin
            // Store the previous value of in
            d_last <= in;

            // Modify the output value
            out <= out | (~in & d_last);
        end
    end
endmodule
