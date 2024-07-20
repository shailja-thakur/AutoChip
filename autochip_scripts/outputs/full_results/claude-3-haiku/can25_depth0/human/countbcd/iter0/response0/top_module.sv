module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 0;
    end
    else begin
        // Implement the BCD counter logic
        q[3:0] <= q[3:0] + 1; // Increment ones digit
        if (q[3:0] == 4'd10) begin // Reached 10 in ones digit
            q[3:0] <= 0;
            q[7:4] <= q[7:4] + 1; // Increment tens digit
            ena[1] <= 1; // Enable increment of hundreds digit
        end
        else begin
            ena[1] <= 0;
        end

        if (q[7:4] == 4'd10) begin // Reached 10 in tens digit
            q[7:4] <= 0;
            q[11:8] <= q[11:8] + 1; // Increment hundreds digit
            ena[2] <= 1; // Enable increment of thousands digit
        end
        else begin
            ena[2] <= 0;
        end

        if (q[11:8] == 4'd10) begin // Reached 10 in hundreds digit
            q[11:8] <= 0;
            q[15:12] <= q[15:12] + 1; // Increment thousands digit
            ena[3] <= 1;
        end
        else begin
            ena[3] <= 0;
        end
    end
end

endmodule
