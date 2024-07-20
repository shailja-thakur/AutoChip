module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b0;  // Reset output to zero
        end else begin
            q <= d;  // Update output with input d
        end
    end

endmodule
