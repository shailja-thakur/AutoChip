module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire ena1, ena2, ena3;

    assign ena[1] = (q[3:0] == 4'd9);  // Enable signal for the tens digit
    assign ena[2] = (q[7:4] == 4'd9) & ena[1];  // Enable signal for the hundreds digit
    assign ena[3] = (q[11:8] == 4'd9) & ena[2];  // Enable signal for the thousands digit

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0;
        end else begin
            q[3:0] <= (q[3:0] == 4'd9) ? 4'd0 : q[3:0] + 4'd1;
            if (ena[1]) begin
                q[7:4] <= (q[7:4] == 4'd9) ? 4'd0 : q[7:4] + 4'd1;
            end
            if (ena[2]) begin
                q[11:8] <= (q[11:8] == 4'd9) ? 4'd0 : q[11:8] + 4'd1;
            end
            if (ena[3]) begin
                q[15:12] <= (q[15:12] == 4'd9) ? 4'd0 : q[15:12] + 4'd1;
            end
        end
    end

endmodule
