module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
            ena <= 0;
        end else begin
            if (q[3:0] == 9 && q[7:4] == 9 && q[11:8] == 9 && q[15:12] == 9) begin
                q <= 0;
                ena <= 7'b0000011;
            end else if (q[3:0] == 9 && q[7:4] == 9 && q[11:8] == 9) begin
                q[15:12] <= q[15:12] + 1;
                q[11:8] <= 0;
                ena <= 7'b000011;
            end else if (q[3:0] == 9 && q[7:4] == 9) begin
                q[11:8] <= q[11:8] + 1;
                q[7:4] <= 0;
                ena <= 7'b000101;
            end else if (q[3:0] == 9) begin
                q[7:4] <= q[7:4] + 1;
                q[3:0] <= 0;
                ena <= 7'b001001;
            end else begin
                q[3:0] <= q[3:0] + 1;
                ena <= 7'b010000;
            end
        end
    end

endmodule
