module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    always @(posedge clk) begin
        if (reset)
            q <= 8'b0;  // set all flip-flops to zero on reset
        else
            q <= d;     // transfer input to output on clock edge
    end

endmodule
