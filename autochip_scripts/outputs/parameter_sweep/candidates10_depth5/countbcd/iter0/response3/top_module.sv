module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
        end else begin
            if (ena == 3'b000) begin
                q[3:0] <= q[3:0] + 1;
            end
            if (ena == 3'b001) begin
                q[7:4] <= q[7:4] + 1;
            end
            if (ena == 3'b010) begin
                q[11:8] <= q[11:8] + 1;
            end
            if (ena == 3'b100) begin
                q[15:12] <= q[15:12] + 1;
            end
        end
    end

endmodule
