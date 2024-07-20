module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 0;
        ena <= 0;
    end
    else begin
        // Increment ones digit
        if (q[3:0] == 4'd9) begin
            q[3:0] <= 0;
            ena[1] <= 1;
            // Increment tens digit
            if (q[7:4] == 4'd9) begin
                q[7:4] <= 0;
                ena[2] <= 1;
                // Increment hundreds digit
                if (q[11:8] == 4'd9) begin
                    q[11:8] <= 0;
                    ena[3] <= 1;
                    // Increment thousands digit
                    if (q[15:12] == 4'd9) begin
                        q[15:12] <= 0;
                        ena[3] <= 0;
                    end
                    else begin
                        q[15:12] <= q[15:12] + 1;
                        ena[3] <= 0;
                    end
                end
                else begin
                    q[11:8] <= q[11:8] + 1;
                    ena[3] <= 0;
                end
            end
            else begin
                q[7:4] <= q[7:4] + 1;
                ena[2] <= 0;
            end
        end
        else begin
            q[3:0] <= q[3:0] + 1;
            ena[1] <= 0;
        end
    end
end

endmodule
