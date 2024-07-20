module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            q_reg <= 0;
        else
            q_reg <= {q_reg[3] ^ q_reg[0], q_reg[4:1]};
    end
    
    always @(posedge clk) begin
        if (reset)
            q <= 1;
        else
            q <= q_reg;
    end
endmodule
