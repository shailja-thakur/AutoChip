module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Define the constants for the maximum value of each digit
parameter MAX_ONES = 4'd9;
parameter MAX_TENS = 4'd9;
parameter MAX_HUNDREDS = 4'd9;
parameter MAX_THOUSANDS = 4'd9;

// Define the enable signals for the upper three digits
assign ena[1] = (q[3:0] == MAX_ONES);
assign ena[2] = (q[7:4] == MAX_TENS) & ena[1];
assign ena[3] = (q[11:8] == MAX_HUNDREDS) & ena[2];

always @(posedge clk) begin
    if (reset) begin
        q <= 16'b0;
    end
    else begin
        // Increment the ones digit
        if (q[3:0] == MAX_ONES) begin
            q[3:0] <= 4'b0;
        end
        else begin
            q[3:0] <= q[3:0] + 1'b1;
        end

        // Increment the tens digit
        if (ena[1]) begin
            if (q[7:4] == MAX_TENS) begin
                q[7:4] <= 4'b0;
            end
            else begin
                q[7:4] <= q[7:4] + 1'b1;
            end
        end

        // Increment the hundreds digit
        if (ena[2]) begin
            if (q[11:8] == MAX_HUNDREDS) begin
                q[11:8] <= 4'b0;
            end
            else begin
                q[11:8] <= q[11:8] + 1'b1;
            end
        end

        // Increment the thousands digit
        if (ena[3]) begin
            if (q[15:12] == MAX_THOUSANDS) begin
                q[15:12] <= 4'b0;
            end
            else begin
                q[15:12] <= q[15:12] + 1'b1;
            end
        end
    end
end

endmodule
