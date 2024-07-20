module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    initial begin
        q = 8'h0; // Set default value to 0
    end

    always @(posedge clk) begin
        q <= d; // Update the register value on the rising edge of the clock
    end
endmodule
