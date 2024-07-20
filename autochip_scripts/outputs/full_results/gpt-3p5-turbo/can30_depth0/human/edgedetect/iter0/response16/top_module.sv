module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);
    reg [7:0] prev_in;  // register to store previous input
    
    always @(posedge clk) begin
        prev_in <= in;  // store current input into previous input register
        
        // detect edge for each bit
        for (int i=0; i<8; i=i+1) begin
            if (prev_in[i] == 0 && in[i] == 1) begin
                pedge[i] <= 1;  // set output bit on next clock cycle after 0 to 1 transition
            end
            else begin
                pedge[i] <= 0;  // otherwise, keep output bit as 0
            end
        end
    end
endmodule
