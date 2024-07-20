module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    reg [3:1] ena_reg = 0;

    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
            ena_reg <= 0;
        end else begin
            if (ena_reg[1]) begin
                if (q[3:0] == 9) begin
                    q[3:0] <= 0;
                end else begin
                    q[3:0] <= q[3:0] + 1;
                end
            end
            if (ena_reg[2]) begin
                if (q[7:4] == 9) begin
                    q[7:4] <= 0;
                end else begin
                    q[7:4] <= q[7:4] + 1;
                end
            end
            if (ena_reg[3]) begin
                if (q[11:8] == 9) begin
                    q[11:8] <= 0;
                end else begin
                    q[11:8] <= q[11:8] + 1;
                end
            end
            ena_reg <= ena;
        end
    end
    
    assign ena = ena_reg;

endmodule
