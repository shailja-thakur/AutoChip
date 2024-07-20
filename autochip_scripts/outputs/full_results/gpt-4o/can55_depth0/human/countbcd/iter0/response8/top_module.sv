module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    // Enable signals logic
    assign ena[1] = (q[3:0] == 4'd9);        // Enable digit[1] increment when digit[0] overflows to 10
    assign ena[2] = (q[7:4] == 4'd9) && ena[1];  // Enable digit[2] increment when digit[1] overflows to 10 and enabled
    assign ena[3] = (q[11:8] == 4'd9) && ena[2]; // Enable digit[3] increment when digit[2] overflows to 10 and enabled

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
        end else begin
            // Increment ones place
            if (q[3:0] == 4'd9)
                q[3:0] <= 4'd0;
            else
                q[3:0] <= q[3:0] + 4'd1;

            // Increment tens place
            if (ena[1]) begin
                if (q[7:4] == 4'd9)
                    q[7:4] <= 4'd0;
                else
                    q[7:4] <= q[7:4] + 4'd1;
            end

            // Increment hundreds place
            if (ena[2]) begin
                if (q[11:8] == 4'd9)
                    q[11:8] <= 4'd0;
                else
                    q[11:8] <= q[11:8] + 4'd1;
            end

            // Increment thousands place
            if (ena[3]) begin
                if (q[15:12] == 4'd9)
                    q[15:12] <= 4'd0;
                else
                    q[15:12] <= q[15:12] + 4'd1;
            end
        end
    end
endmodule
