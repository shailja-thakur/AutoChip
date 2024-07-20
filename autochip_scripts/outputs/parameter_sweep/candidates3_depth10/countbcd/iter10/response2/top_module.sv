module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

    reg [3:1] ena_reg;
    reg [15:0] q_reg;
    
    always @(posedge clk) begin
        if (reset) begin
            q_reg <= 0;
            ena_reg <= 3'b0;
        end else begin
            q_reg <= q_reg + 1;
            ena_reg <= ena_reg << 1;
        end
    end
    
    assign ena = ena_reg;
    assign q = q_reg;
endmodule
