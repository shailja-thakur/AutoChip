module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Define constants for the maximum value of each digit
localparam MAX_ONES   = 4'd9;
localparam MAX_TENS   = 4'd9;
localparam MAX_HUNDREDS = 4'd9;
localparam MAX_THOUSANDS = 4'd9;

always @(posedge clk) begin
    if (reset) begin
        // Reset the counter to 0000
        q <= 16'b0;
    end
    else begin
        // Increment the ones digit
        if (q[3:0] == MAX_ONES) begin
            q[3:0] <= 4'b0;
            ena[1] = 1'b1; // Enable the tens digit
        end
        else begin
            q[3:0] <= q[3:0] + 1'b1;
            ena[1] = 1'b0;
        end

        // Increment the tens digit
        if (q[7:4] == MAX_TENS && ena[1]) begin
            q[7:4] <= 4'b0;
            ena[2] = 1'b1; // Enable the hundreds digit
        end
        else if (ena[1]) begin
            q[7:4] <= q[7:4] + 1'b1;
            ena[2] = 1'b0;
        end

        // Increment the hundreds digit
        if (q[11:8] == MAX_HUNDREDS && ena[2]) begin
            q[11:8] <= 4'b0;
            ena[3] = 1'b1; // Enable the thousands digit
        end
        else if (ena[2]) begin
            q[11:8] <= q[11:8] + 1'b1;
            ena[3] = 1'b0;
        end

        // Increment the thousands digit
        if (q[15:12] == MAX_THOUSANDS && ena[3]) begin
            q[15:12] <= 4'b0;
        end
        else if (ena[3]) begin
            q[15:12] <= q[15:12] + 1'b1;
        end
    end
end

endmodule
