module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire c0, c1, c2;

    assign ena = {c2, c1, c0};

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
        end
        else begin
            // Ones place (4 bits)
            if (q[3:0] == 4'b1001) begin
                q[3:0] <= 4'b0000;
                c0 <= 1'b1;
            end
            else begin
                q[3:0] <= q[3:0] + 1;
                c0 <= 1'b0;
            end

            // Tens place (4 bits)
            if (c0) begin
                if (q[7:4] == 4'b1001) begin
                    q[7:4] <= 4'b0000;
                    c1 <= 1'b1;
                end
                else begin
                    q[7:4] <= q[7:4] + 1;
                    c1 <= 1'b0;
                end
            end

            // Hundreds place (4 bits)
            if (c1) begin
                if (q[11:8] == 4'b1001) begin
                    q[11:8] <= 4'b0000;
                    c2 <= 1'b1;
                end
                else begin
                    q[11:8] <= q[11:8] + 1;
                    c2 <= 1'b0;
                end
            end

            // Thousands place (4 bits)
            if (c2) begin
                if (q[15:12] == 4'b1001) begin
                    q[15:12] <= 4'b0000;
                end
                else begin
                    q[15:12] <= q[15:12] + 1;
                end
            end
        end
    end
endmodule
