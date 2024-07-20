module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    // Initial block to set the output to a default value
    initial begin
        q = 8'h00;
    end

    // Always block triggered on the rising edge of the clock input
    always @(posedge clk) begin
        q <= d;
    end
endmodule
