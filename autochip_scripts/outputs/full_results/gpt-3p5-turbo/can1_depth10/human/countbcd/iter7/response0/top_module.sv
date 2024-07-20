module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    reg [3:1] ena_reg;
    reg [15:0] q_reg;
    reg [3:0] q_temp;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q_reg <= 0;
            ena_reg <= 0;
        end else begin
            q_temp <= q_reg;
            if (ena_reg[1]) begin
                q_temp[3:0] <= q_temp[3:0] + 1;
            end
            if (ena_reg[2]) begin
                q_temp[7:4] <= q_temp[7:4] + 1;
            end
            if (ena_reg[3]) begin
                q_temp[11:8] <= q_temp[11:8] + 1;
            end
            ena_reg <= ena;
            q_reg <= q_temp;
        end
    end
    
    assign ena = ena_reg;
    assign q = q_reg;
    
endmodule
