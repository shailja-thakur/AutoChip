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
        if (q[3:0] == 4'd9) begin
            q[3:0] <= 4'd0;
            ena[1] <= 1'b1;
        end
        else begin
            q[3:0] <= q[3:0] + 1'b1;
            ena[1] <= 1'b0;
        end

        if (q[7:4] == 4'd9 && ena[1]) begin
            q[7:4] <= 4'd0;
            ena[2] <= 1'b1;
        end
        else begin
            q[7:4] <= q[7:4] + (ena[1] & 1'b1);
            ena[2] <= 1'b0;
        end

        if (q[11:8] == 4'd9 && ena[2]) begin
            q[11:8] <= 4'd0;
            ena[3] <= 1'b1;
        end
        else begin
            q[11:8] <= q[11:8] + (ena[2] & 1'b1);
            ena[3] <= 1'b0;
        end

        if (q[15:12] == 4'd9 && ena[3]) begin
            q[15:12] <= 4'd0;
        end
        else begin
            q[15:12] <= q[15:12] + (ena[3] & 1'b1);
        end
    end
end

endmodule
