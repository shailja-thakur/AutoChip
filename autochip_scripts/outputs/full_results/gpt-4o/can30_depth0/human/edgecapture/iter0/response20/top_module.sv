module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] in_delayed;

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
            in_delayed <= 32'b0;
        end
        else begin
            // Capture transition from 1 to 0 for each bit
            out <= out | (in_delayed & ~in);
            // Update delayed input
            in_delayed <= in;
        end
    end
endmodule
