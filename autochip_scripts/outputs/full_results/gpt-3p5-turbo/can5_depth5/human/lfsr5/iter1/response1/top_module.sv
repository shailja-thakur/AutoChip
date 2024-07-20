module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            q_reg <= 1;
        else begin
            q_reg[4] <= q_reg[3] ^ q_reg[0];
            q_reg[3:0] <= q_reg[4:1];
        end
    end
    
    assign q = q_reg;

endmodule
