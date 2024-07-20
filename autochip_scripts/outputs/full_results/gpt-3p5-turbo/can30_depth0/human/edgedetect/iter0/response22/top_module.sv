module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    always @(posedge clk) begin
        for (integer i = 0; i < 8; i = i + 1) begin
            if (in[i] == 0 && in[i] != previous_in[i])
                pedge[i] <= 1;
            else
                pedge[i] <= 0;
            
            previous_in[i] <= in[i];
        end
    end
    
    reg [7:0] previous_in;
    
endmodule
