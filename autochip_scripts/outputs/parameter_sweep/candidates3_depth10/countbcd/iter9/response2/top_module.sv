module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

    reg [3:1] ena_reg;
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
            ena_reg <= 3'b0;
        end else begin
            q <= q + 1;
            ena_reg <= ena_reg << 1;
        end
    end
    
    assign ena = ena_reg;

endmodule
