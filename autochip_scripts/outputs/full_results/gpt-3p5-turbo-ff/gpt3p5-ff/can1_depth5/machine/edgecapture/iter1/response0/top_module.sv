module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] d_last;
    reg [31:0] out_temp;
    
    always @(posedge clk) begin
        if (reset)
            out_temp <= 0;
        else begin
            d_last <= in;
            out_temp <= out_temp | (~in & d_last);
        end
    end
    
    always @(posedge clk) begin
        if (reset)
            out <= 0;
        else
            out <= out_temp;
    end

endmodule
