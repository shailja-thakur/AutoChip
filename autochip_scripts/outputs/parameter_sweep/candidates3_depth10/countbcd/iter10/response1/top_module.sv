module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
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
            if (ena_reg[3] == 1'b1) begin
                ena_reg <= 3'b0;
            end
        end
        ena <= ena_reg;
    end
    
endmodule
