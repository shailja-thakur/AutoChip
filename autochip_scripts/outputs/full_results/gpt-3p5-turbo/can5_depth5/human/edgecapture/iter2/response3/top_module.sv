module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] previous_in;
    reg [31:0] held_in;
  
    always @(posedge clk) begin
        if (reset) begin
            out <= 0;
            previous_in <= 0;
            held_in <= 0;
        end
        else begin
            if (in !== previous_in) begin
                out <= out | (held_in & (~in));
            end
            previous_in <= in;
            held_in <= in;
        end
    end
          
endmodule
