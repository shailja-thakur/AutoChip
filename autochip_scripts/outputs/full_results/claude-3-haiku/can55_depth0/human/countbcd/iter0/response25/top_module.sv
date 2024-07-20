module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Define constants for the decimal digit values
parameter ONES_MAX = 4'd9;
parameter TENS_MAX = 4'd9;
parameter HUNDREDS_MAX = 4'd9;
parameter THOUSANDS_MAX = 4'd9;

// Define the enable signals for the upper three digits
assign ena[1] = (q[3:0] == ONES_MAX);
assign ena[2] = (q[7:4] == TENS_MAX) & ena[1];
assign ena[3] = (q[11:8] == HUNDREDS_MAX) & ena[2];

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 16'b0;
    end
    else begin
        // Increment the ones digit
        if (q[3:0] == ONES_MAX) begin
            q[3:0] <= 4'b0;
            // Increment the tens digit if the ones digit rolled over
            if (q[7:4] == TENS_MAX) begin
                q[7:4] <= 4'b0;
                // Increment the hundreds digit if the tens digit rolled over
                if (q[11:8] == HUNDREDS_MAX) begin
                    q[11:8] <= 4'b0;
                    // Increment the thousands digit if the hundreds digit rolled over
                    if (q[15:12] == THOUSANDS_MAX) begin
                        q[15:12] <= 4'b0;
                    end
                    else begin
                        q[15:12] <= q[15:12] + 4'b1;
                    end
                end
                else begin
                    q[11:8] <= q[11:8] + 4'b1;
                end
            end
            else begin
                q[7:4] <= q[7:4] + 4'b1;
            end
        end
        else begin
            q[3:0] <= q[3:0] + 4'b1;
        end
    end
end

endmodule
