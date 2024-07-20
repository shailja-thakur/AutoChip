module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    reg [15:0] q_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q_reg <= 0;
        end else begin
            if (ena[1]) begin
                q_reg[7:4] <= q_reg[7:4] + 1;
            end
            if (ena[2]) begin
                q_reg[11:8] <= q_reg[11:8] + 1;
            end
            if (ena[3]) begin
                q_reg[15:12] <= q_reg[15:12] + 1;
            end
            q_reg[3:0] <= q_reg[3:0] + 1;
        end
    end
    
    assign q = q_reg;
    
endmodule
