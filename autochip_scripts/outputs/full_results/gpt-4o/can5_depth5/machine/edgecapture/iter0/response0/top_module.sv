module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] d_last;  // Register to store the previous value of 'in'

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 32'b0;         // Reset the output to 0
            d_last <= 32'b0;      // Reset the previous input value to 0
        end else begin
            d_last <= in;         // Store current input value to d_last
            out <= out | (~in & d_last); // Modify output value according to the given condition
        end
    end

endmodule
