module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 0;
    end
    else begin
        // Increment ones digit
        if (q[3:0] == 4'b1001) begin
            q[3:0] <= 0;
            ena[1] = 1'b1; // Tens digit should increment
        end
        else begin
            q[3:0] <= q[3:0] + 1'b1;
            ena[1] = 1'b0;
        end

        // Increment tens digit
        if (q[7:4] == 4'b1001) begin
            q[7:4] <= 0;
            ena[2] = 1'b1; // Hundreds digit should increment
        end
        else if (ena[1]) begin
            q[7:4] <= q[7:4] + 1'b1;
            ena[2] = 1'b0;
        end

        // Increment hundreds digit
        if (q[11:8] == 4'b1001) begin
            q[11:8] <= 0;
            ena[3] = 1'b1; // Thousands digit should increment
        end
        else if (ena[2]) begin
            q[11:8] <= q[11:8] + 1'b1;
            ena[3] = 1'b0;
        end

        // Increment thousands digit
        if (q[15:12] == 4'b1001) begin
            q[15:12] <= 0;
        end
        else if (ena[3]) begin
            q[15:12] <= q[15:12] + 1'b1;
        end
    end
end

endmodule
