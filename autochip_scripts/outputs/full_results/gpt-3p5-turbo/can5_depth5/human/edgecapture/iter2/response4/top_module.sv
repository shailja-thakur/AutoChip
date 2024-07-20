module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] previous_in;
    reg [31:0] delayed_in;
  
    always @(posedge clk) begin
        if (reset) begin
            out <= 0;
            previous_in <= 0;
            delayed_in <= 0;
        end
        else begin
            previous_in <= in;
            delayed_in <= previous_in;
            out <= out | (delayed_in & (~in));
        end
    end
          
endmodule
