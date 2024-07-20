module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

parameter ONES_MAX = 4'd9;
parameter TENS_MAX = 4'd9;
parameter HUNDREDS_MAX = 4'd9;
parameter THOUSANDS_MAX = 4'd9;

always @(posedge clk) begin
    if (reset) begin
        q <= 16'b0;
    end
    else begin
        // Increment ones digit
        if (q[3:0] == ONES_MAX) begin
            q[3:0] <= 4'b0;
            ena[1] <= 1'b1;
        end
        else begin
            q[3:0] <= q[3:0] + 1'b1;
            ena[1] <= 1'b0;
        end

        // Increment tens digit
        if (ena[1] && q[7:4] == TENS_MAX) begin
            q[7:4] <= 4'b0;
            ena[2] <= 1'b1;
        end
        else if (ena[1]) begin
            q[7:4] <= q[7:4] + 1'b1;
            ena[2] <= 1'b0;
        end

        // Increment hundreds digit
        if (ena[2] && q[11:8] == HUNDREDS_MAX) begin
            q[11:8] <= 4'b0;
            ena[3] <= 1'b1;
        end
        else if (ena[2]) begin
            q[11:8] <= q[11:8] + 1'b1;
            ena[3] <= 1'b0;
        end

        // Increment thousands digit
        if (ena[3] && q[15:12] == THOUSANDS_MAX) begin
            q[15:12] <= 4'b0;
        end
        else if (ena[3]) begin
            q[15:12] <= q[15:12] + 1'b1;
        end
    end
end

endmodule
