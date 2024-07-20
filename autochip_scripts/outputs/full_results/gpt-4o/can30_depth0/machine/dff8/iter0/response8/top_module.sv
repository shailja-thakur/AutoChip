module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    // Initialize the output to 0
    initial begin
        q = 8'h00;
    end

    // Always block triggered on the rising edge of clk
    always @(posedge clk) begin
        q <= d;
    end

endmodule
