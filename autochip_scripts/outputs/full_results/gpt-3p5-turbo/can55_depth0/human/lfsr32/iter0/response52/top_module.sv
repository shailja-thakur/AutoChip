module top_module(
    input clk,
    input reset,
    output reg [31:0] q);
    
    reg [31:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 32'h1;
        else begin
            state[31] <= (state[31] ^ state[22] ^ state[2] ^ state[1]);
            state[30:0] <= state[31:1];
        end
    end
    
    assign q = state;
    
endmodule
