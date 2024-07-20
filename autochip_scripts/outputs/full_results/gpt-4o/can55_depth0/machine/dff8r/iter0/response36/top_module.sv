module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b0; // Reset the register to 0
        end
        else begin
            q <= d; // Store the value of the data input d
        end
    end
endmodule
