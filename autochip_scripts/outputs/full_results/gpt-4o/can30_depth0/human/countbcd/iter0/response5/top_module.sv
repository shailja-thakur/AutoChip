module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    // Enable signals for each digit
    assign ena[1] = (q[3:0] == 4'd9);
    assign ena[2] = (q[7:4] == 4'd9) && ena[1];
    assign ena[3] = (q[11:8] == 4'd9) && ena[2];

    // Synchronous operations
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'h0000; // reset the counter to 0
        end else begin
            // Handle the ones place
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
            end else begin
                q[3:0] <= q[3:0] + 1;
            end

            // Handle the tens place
            if (ena[1]) begin
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                end else begin
                    q[7:4] <= q[7:4] + 1;
                end
            end

            // Handle the hundreds place
            if (ena[2]) begin
                if (q[11:8] == 4'd9) begin
                    q[11:8] <= 4'd0;
                end else begin
                    q[11:8] <= q[11:8] + 1;
                end
            end

            // Handle the thousands place
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
