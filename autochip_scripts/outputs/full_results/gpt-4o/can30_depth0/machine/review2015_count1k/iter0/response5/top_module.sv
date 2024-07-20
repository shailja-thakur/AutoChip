module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) 
            q <= 10'd0;
        else if (q == 10'd999) 
            q <= 10'd0;
        else 
            q <= q + 1;
    end
endmodule
