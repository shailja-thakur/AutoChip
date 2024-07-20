module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_reg;
    wire [4:0] q_next;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            q_reg <= 1;
        else
            q_reg <= q_next;
    end
    
    assign q_next[4] = q_reg[3] ^ q_reg[1];
    assign q_next[3:0] = q_reg[4:1];
    
    assign q = q_reg;

endmodule
