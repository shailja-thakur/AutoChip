module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    always @(posedge clk) begin
        if (reset) begin
            // Reset all digits to 0 on reset
            q <= 16'd0;
        end
        else begin
            // Increment the ones place
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                ena[1] <= 1'b1;   // Indicate the tens place should increment
            end else begin
                q[3:0] <= q[3:0] + 1;
                ena[1] <= 1'b0;
            end
            
            // Increment the tens place if enabled
            if (ena[1]) begin
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    ena[2] <= 1'b1;   // Indicate the hundreds place should increment
                end else begin
                    q[7:4] <= q[7:4] + 1;
                    ena[2] <= 1'b0;
                end
            end

            // Increment the hundreds place if enabled
            if (ena[2]) begin
                if (q[11:8] == 4'd9) begin
                    q[11:8] <= 4'd0;
                    ena[3] <= 1'b1;   // Indicate the thousands place should increment
                end else begin
                    q[11:8] <= q[11:8] + 1;
                    ena[3] <= 1'b0;
                end
            end
            
            // Increment the thousands place if enabled
            if (ena[3]) begin
                if (q[15:12] == 4'd9) begin
                    q[15:12] <= 4'd0;
                end else begin
                    q[15:12] <= q[15:12] + 1;
                end
            end
        end
    end
endmodule
