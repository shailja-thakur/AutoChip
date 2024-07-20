module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 16'b0;
    end
    else begin
        // Increment ones digit
        if (q[3:0] == 4'b1001) begin
            q[3:0] <= 4'b0000;
            ena[1] <= 1'b1;
        end
        else begin
            q[3:0] <= q[3:0] + 1'b1;
            ena[1] <= 1'b0;
        end

        // Increment tens digit
        if (q[7:4] == 4'b1001 && ena[1]) begin
            q[7:4] <= 4'b0000;
            ena[2] <= 1'b1;
        end
        else begin
            q[7:4] <= q[7:4] + (ena[1] ? 1'b1 : 1'b0);
            ena[2] <= 1'b0;
        end

        // Increment hundreds digit
        if (q[11:8] == 4'b1001 && ena[2]) begin
            q[11:8] <= 4'b0000;
            ena[3] <= 1'b1;
        end
        else begin
            q[11:8] <= q[11:8] + (ena[2] ? 1'b1 : 1'b0);
            ena[3] <= 1'b0;
        end

        // Increment thousands digit
        if (q[15:12] == 4'b1001 && ena[3]) begin
            q[15:12] <= 4'b0000;
        end
        else begin
            q[15:12] <= q[15:12] + (ena[3] ? 1'b1 : 1'b0);
        end
    end
end

endmodule
