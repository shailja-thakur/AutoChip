module top_module(
    input clk,
    input reset,
    output wire [3:1] ena,
    output wire [15:0] q
);

reg [15:0] q_reg;
reg [2:0] ena_reg;

always @(posedge clk) begin
    if(reset) begin
        q_reg <= 16'b0;
        ena_reg <= 3'b0;
    end else begin
        q_reg <= q_reg;
        ena_reg <= ena_reg;
    end
end

always @(posedge clk) begin
    if(reset) begin
        q <= 16'b0;
        ena <= 3'b0;
    end else begin
        if(ena_reg[1] == 1'b1 && q_reg[3:0] == 4'b1001) begin
            q[3:0] <= 4'b0000;
            ena[1] <= 1'b0;
        end else if (ena_reg[1] == 1'b1 && q_reg[3:0] != 4'b1001) begin
            q[3:0] <= q[3:0] + 1;
        end
        if(ena_reg[2] == 1'b1 && q_reg[7:4] == 4'b1001) begin
            q[7:4] <= 4'b0000;
            ena[2] <= 1'b0;
        end else if (ena_reg[2] == 1'b1 && q_reg[7:4] != 4'b1001) begin
            q[7:4] <= q[7:4] + 1;
            q[3:0] <= 4'b0000;
            ena[1] <= 1'b1;
        end
        if(ena_reg[3] == 1'b1 && q_reg[11:8] == 4'b1001) begin
            q[11:8] <= 4'b0000;
            ena[3] <= 1'b0;
        end else if (ena_reg[3] == 1'b1 && q_reg[11:8] != 4'b1001) begin
            q[11:8] <= q[11:8] + 1;
            q[7:4] <= 4'b0000;
            ena[2] <= 1'b1;
        end
        if(q_reg[15:12] == 4'b1001) begin
            q[15:12] <= 4'b0000;
            ena[3] <= 1'b0;
        end else if (q_reg[15:12] != 4'b1001) begin
            q[15:12] <= q[15:12] + 1;
            q[11:8] <= 4'b0000;
            ena[3] <= 1'b1;
        end
    end
end

endmodule
