module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] previous_in;
    reg [31:0] out_reg;
    reg [31:0] in_reg;
  
    always @(posedge clk) begin
        if (reset) begin
            out_reg <= 0;
            previous_in <= 0;
            in_reg <= 0;
        end
        else begin
            in_reg <= in;
            if (in_reg !== previous_in) begin
                out_reg <= (out_reg | (previous_in & (~in_reg)));
                previous_in <= in_reg;
            end
        end
    end
    
    assign out = out_reg;
          
endmodule
