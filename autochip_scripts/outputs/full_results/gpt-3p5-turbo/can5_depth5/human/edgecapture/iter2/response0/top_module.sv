module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] previous_in;
  
    always @(posedge clk) begin
        if (reset) begin
            out <= 0;
            previous_in <= 0;
        end
        else if (in !== previous_in) begin
            out <= out | (previous_in & (~in));
            previous_in <= in;
        end
        else begin
            out <= out & in;
            previous_in <= in;
        end
    end
          
endmodule
