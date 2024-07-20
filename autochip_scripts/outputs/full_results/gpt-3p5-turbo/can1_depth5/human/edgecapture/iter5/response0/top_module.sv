module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] in_previous;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            in_previous <= 0;
        else begin
            in_previous <= in;
            out <= in_previous & (~in_previous);
        end
    end

endmodule
