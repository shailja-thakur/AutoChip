module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] d_last;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 32'h0;  // Set initial value of out to 0
        end else begin
            d_last <= in;  // Store the previous value of in
            // Modify out based on the input and previous input values
            out <= out | (~in & d_last);
        end
    end
endmodule
