module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire inc_1, inc_10, inc_100;

    // Enable signals for each digit
    assign ena[1] = (q[3:0] == 4'd9) ? 1 : 0;
    assign ena[2] = (q[7:4] == 4'd9 && ena[1]) ? 1 : 0;
    assign ena[3] = (q[11:8] == 4'd9 && ena[2]) ? 1 : 0;

    // Increment signals for each digit
    assign inc_1 = 1;
    assign inc_10 = (q[3:0] == 4'd9);
    assign inc_100 = (q[7:4] == 4'd9 && inc_10);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
        end else begin
            if (inc_1) begin
                if (q[3:0] == 4'd9)
                    q[3:0] <= 4'd0;
                else
                    q[3:0] <= q[3:0] + 4'd1;
            end

            if (inc_10) begin
                if (q[7:4] == 4'd9)
                    q[7:4] <= 4'd0;
                else
                    q[7:4] <= q[7:4] + 4'd1;
            end

            if (inc_100) begin
                if (q[11:8] == 4'd9)
                    q[11:8] <= 4'd0;
                else
                    q[11:8] <= q[11:8] + 4'd1;
            end

            if (ena[3]) begin
                if (q[15:12] == 4'd9)
                    q[15:12] <= 4'd0;
                else
                    q[15:12] <= q[15:12] + 4'd1;
            end
        end
    end
endmodule
