module top_module(
    input clk,
    input reset,
    output reg [4:0] q);
    
    reg [4:0] d;

    always @(posedge clk or posedge reset) begin
        if (reset)
            d <= 5'b1;
        else
            d <= {d[3] ^ d[2], d[4:1]};
    end

    assign q = d;

endmodule
