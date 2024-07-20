module top_module(
    input clk,
    input reset,
    output reg [31:0] q);
    
    reg [31:0] lfsr;
        
    always @(posedge clk or posedge reset) begin
        if (reset)
            lfsr <= 32'h1;
        else begin
            lfsr[0] <= lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0];
            lfsr[31:1] <= lfsr[30:0];
        end
    end
    
    assign q = lfsr;
    
endmodule
