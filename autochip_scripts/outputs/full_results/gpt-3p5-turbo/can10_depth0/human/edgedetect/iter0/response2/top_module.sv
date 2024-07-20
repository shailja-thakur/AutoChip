module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);
    
    reg [7:0] in_ff;
    
    always @(posedge clk) begin
        in_ff <= in;
        pedge <= 0;
        
        for (int i = 0; i < 8; i = i + 1) begin
            if (in_ff[i] == 0 && in[i] == 1) begin
                pedge[i] <= 1;
            end
        end
    end
    
endmodule
