module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] in_d; // previous state of in

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
        end
        else begin
            // Update 'out' where a change from 1 to 0 is detected
            out <= out | (in_d & ~in);
        end
        // Store the previous state of 'in'
        in_d <= in;
    end
endmodule
