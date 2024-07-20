module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

    reg [31:0] in_d; // Register to store the previous cycle value of the input

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
        end else begin
            out <= out | (in_d & ~in);
        end
        in_d <= in; // Update the previous cycle value
    end

endmodule
