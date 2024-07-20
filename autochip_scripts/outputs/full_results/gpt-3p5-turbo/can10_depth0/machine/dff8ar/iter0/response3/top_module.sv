module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q);

    always @(posedge clk or posedge areset) begin
        if (areset == 1'b1)
            q <= 8'b0;
        else
            q <= d;
    end

endmodule
