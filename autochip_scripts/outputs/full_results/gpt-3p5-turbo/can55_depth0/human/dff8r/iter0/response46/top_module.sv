module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    reg [7:0] q_reg;  // Register to store the output

    always @(posedge clk) begin
        if (reset) begin
            q_reg <= 8'b0;  // Reset the output to zero
        end else begin
            q_reg <= d;  // Update the output with the input
        end
    end

    assign q = q_reg;

endmodule
