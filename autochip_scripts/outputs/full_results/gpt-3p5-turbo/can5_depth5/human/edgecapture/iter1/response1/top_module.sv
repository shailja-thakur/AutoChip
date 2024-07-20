module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] previous_in;
    reg [31:0] positive_edge;
  
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 0;
            previous_in <= 0;
            positive_edge <= 0;
        end
        else begin
            positive_edge <= in & (~previous_in);
            out <= out | positive_edge;
            previous_in <= in;
        end
    end
          
endmodule
