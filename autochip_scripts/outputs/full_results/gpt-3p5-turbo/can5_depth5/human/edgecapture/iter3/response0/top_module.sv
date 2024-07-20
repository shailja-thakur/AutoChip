module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] previous_in;
    reg [31:0] out_reg;
    wire [31:0] out_delay;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_reg <= 0;
            previous_in <= 0;
        end
        else begin
            previous_in <= in;
            out_reg <= out_delay;
        end
    end
    
    assign out_delay = (previous_in & (~in));
    assign out = out_reg | out_delay;
          
endmodule
