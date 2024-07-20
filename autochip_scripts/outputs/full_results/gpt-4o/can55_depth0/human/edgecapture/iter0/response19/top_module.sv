module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] prev_in;

    // Always block to capture the change from 1 to 0 in 'in' and set 'out' accordingly
    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;  // Synchronous reset
            prev_in <= 32'b0;
        end
        else begin
            // Capture the change from 1 to 0
            out <= out | (prev_in & ~in);
            prev_in <= in;
        end
    end
endmodule
