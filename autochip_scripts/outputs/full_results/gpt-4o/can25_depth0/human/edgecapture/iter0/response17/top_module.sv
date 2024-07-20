module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] in_d; // Register to hold the delayed value of in

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0; // Reset output to 0
            in_d <= 32'b0; // Reset the delayed input to 0
        end 
        else begin
            // Capture the transition from 1 to 0
            out <= out | (in_d & ~in);
            in_d <= in; // Update the delayed input
        end
    end
endmodule
