module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire carry0, carry1, carry2;

    assign ena[1] = carry0;
    assign ena[2] = carry1;
    assign ena[3] = carry2;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
        end else begin
            // Ones place
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                carry0 <= 1;
            end else begin
                q[3:0] <= q[3:0] + 1;
                carry0 <= 0;
            end

            // Tens place
            if (carry0) begin
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    carry1 <= 1;
                end else begin
                    q[7:4] <= q[7:4] + 1;
                    carry1 <= 0;
                end
            end else begin
                carry1 <= 0;
            end

            // Hundreds place
            if (carry1) begin
                if (q[11:8] == 4'd9) begin
                    q[11:8] <= 4'd0;
                    carry2 <= 1;
                end else begin
                    q[11:8] <= q[11:8] + 1;
                    carry2 <= 0;
                end
            end else begin
                carry2 <= 0;
            end

            // Thousands place
            if (carry2) begin
                if (q[15:12] == 4'd9) begin
                    q[15:12] <= 4'd0;
                end else begin
                    q[15:12] <= q[15:12] + 1;
                end
            end
        end
    end
endmodule
