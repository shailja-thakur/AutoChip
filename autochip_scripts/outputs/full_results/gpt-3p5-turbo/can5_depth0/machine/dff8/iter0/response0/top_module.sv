module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    // Register initialization
    initial begin
        q = 8'h0;
    end

    // Register operation on positive clock edge
    always @(posedge clk) begin
        q <= d;
    end

endmodule
