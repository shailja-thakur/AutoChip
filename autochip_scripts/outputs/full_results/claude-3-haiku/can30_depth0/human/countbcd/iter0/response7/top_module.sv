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
        // Increment the ones digit
        if (q[3:0] == 4'd9) begin
            q[3:0] <= 0;
            ena[1] <= 1;
        end
        else begin
            q[3:0] <= q[3:0] + 1;
            ena[1] <= 0;
        end

        // Increment the tens digit
        if (q[7:4] == 4'd9 && ena[1]) begin
            q[7:4] <= 0;
            ena[2] <= 1;
        end
        else begin
            q[7:4] <= q[7:4] + (ena[1] ? 1 : 0);
            ena[2] <= 0;
        end

        // Increment the hundreds digit
        if (q[11:8] == 4'd9 && ena[2]) begin
            q[11:8] <= 0;
            ena[3] <= 1;
        end
        else begin
            q[11:8] <= q[11:8] + (ena[2] ? 1 : 0);
            ena[3] <= 0;
        end

        // Increment the thousands digit
        if (q[15:12] == 4'd9 && ena[3]) begin
            q[15:12] <= 0;
        end
        else begin
            q[15:12] <= q[15:12] + (ena[3] ? 1 : 0);
        end
    end
end

endmodule
