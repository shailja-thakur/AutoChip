module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    // Initialize the output register q to a default value of 0
    initial begin
        q = 8'h0;
    end

    // Always block to store data on rising edge of the clock
    always @(posedge clk) begin
        q <= d;
    end

endmodule
