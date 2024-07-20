module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [7:0] in_reg1;
reg [7:0] in_reg2;
reg [7:0] in_reg3;
reg [7:0] in_prev1;
reg [7:0] in_prev2;
reg reset_reg;
reg reset_sync;

always @(posedge clk or posedge reset) begin
    if (reset)
        reset_reg <= 1'b1;
    else
        reset_reg <= 1'b0;
end

always @(posedge clk) begin
    reset_sync <= reset_reg;
end

always @(posedge clk or posedge reset) begin
    if (reset_sync)
        in_reg1 <= 8'b0;
    else
        in_reg1 <= in;
end

always @(posedge clk or posedge reset) begin
    if (reset_sync)
        in_reg2 <= 8'b0;
    else
        in_reg2 <= in_reg1;
end

always @(posedge clk or posedge reset) begin
    if (reset_sync)
        in_reg3 <= 8'b0;
    else
        in_reg3 <= in_reg2;
end

always @(posedge clk) begin
    if (reset_sync)
        in_prev1 <= 8'b0;
    else
        in_prev1 <= in_reg1;
end

always @(posedge clk) begin
    if (reset_sync)
        in_prev2 <= 8'b0;
    else
        in_prev2 <= in_reg2;
end

always @(posedge clk or posedge reset) begin
    if (reset_sync)
        done <= 1'b0;
    else if (in_prev2[3] && in_prev1[3] && in_reg1[3])
        done <= 1'b1;
    else
        done <= 1'b0;
end

endmodule
