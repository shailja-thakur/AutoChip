module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire inc1, inc2, inc3;

    assign ena[1] = inc1;
    assign ena[2] = inc2;
    assign ena[3] = inc3;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
        end 
        else begin
            // Ones place
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                inc1 <= 1;
            end
            else begin
                q[3:0] <= q[3:0] + 1;
                inc1 <= 0;
            end

            // Tens place
            if (inc1) begin
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    inc2 <= 1;
                end
                else begin
                    q[7:4] <= q[7:4] + 1;
                    inc2 <= 0;
                end
            end

            // Hundreds place
            if (inc2) begin
                if (q[11:8] == 4'd9) begin
                    q[11:8] <= 4'd0;
                    inc3 <= 1;
                end
                else begin
                    q[11:8] <= q[11:8] + 1;
                    inc3 <= 0;
                end
            end

            // Thousands place
            if (inc3) begin
                if (q[15:12] == 4'd9) begin
                    q[15:12] <= 4'd0;
                end
                else begin
                    q[15:12] <= q[15:12] + 1;
                end
            end
        end
    end
endmodule
