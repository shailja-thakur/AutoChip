module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire inc_ena[3:1];

    assign ena[1] = inc_ena[1];
    assign ena[2] = inc_ena[2];
    assign ena[3] = inc_ena[3];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0;
        end else begin
            // Increment ones place
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                inc_ena[1] <= 1'b1;
            end else begin
                q[3:0] <= q[3:0] + 4'd1;
                inc_ena[1] <= 1'b0;
            end

            // Increment tens place
            if (inc_ena[1]) begin
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    inc_ena[2] <= 1'b1;
                end else begin
                    q[7:4] <= q[7:4] + 4'd1;
                    inc_ena[2] <= 1'b0;
                end
            end

            // Increment hundreds place
            if (inc_ena[2]) begin
                if (q[11:8] == 4'd9) begin
                    q[11:8] <= 4'd0;
                    inc_ena[3] <= 1'b1;
                end else begin
                    q[11:8] <= q[11:8] + 4'd1;
                    inc_ena[3] <= 1'b0;
                end
            end

            // Increment thousands place
            if (inc_ena[3]) begin
                if (q[15:12] == 4'd9) begin
                    q[15:12] <= 4'd0;
                end else begin
                    q[15:12] <= q[15:12] + 4'd1;
                end
            end
        end
    end

endmodule
