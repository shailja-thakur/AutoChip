module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire carry0, carry1, carry2, carry3;

    // Synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            q <= 16'd0;
        end else begin
            // Increment ones digit
            if (q[3:0] == 4'b1001) begin
                q[3:0] <= 4'b0000;
                carry0 <= 1'b1;
            end else begin
                q[3:0] <= q[3:0] + 1'b1;
                carry0 <= 1'b0;
            end

            // Increment tens digit
            if (carry0) begin
                if (q[7:4] == 4'b1001) begin
                    q[7:4] <= 4'b0000;
                    carry1 <= 1'b1;
                end else begin
                    q[7:4] <= q[7:4] + 1'b1;
                    carry1 <= 1'b0;
                end
            end else begin
                carry1 <= 1'b0;
            end

            // Increment hundreds digit
            if (carry1) begin
                if (q[11:8] == 4'b1001) begin
                    q[11:8] <= 4'b0000;
                    carry2 <= 1'b1;
                end else begin
                    q[11:8] <= q[11:8] + 1'b1;
                    carry2 <= 1'b0;
                end
            end else begin
                carry2 <= 1'b0;
            end

            // Increment thousands digit
            if (carry2) begin
                if (q[15:12] == 4'b1001) begin
                    q[15:12] <= 4'b0000;
                    carry3 <= 1'b1;
                end else begin
                    q[15:12] <= q[15:12] + 1'b1;
                    carry3 <= 1'b0;
                end
            end else begin
                carry3 <= 1'b0;
            end
        end
    end

    // Enable signals for incrementing digits
    assign ena[1] = (q[3:0] == 4'b1001);
    assign ena[2] = (q[7:4] == 4'b1001) && (q[3:0] == 4'b1001);
    assign ena[3] = (q[11:8] == 4'b1001) && (q[7:4] == 4'b1001) && (q[3:0] == 4'b1001);

endmodule
