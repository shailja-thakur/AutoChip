module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
        end
        else begin
            if (q[3:0] == 4'b1001) begin
                q[3:0] <= 4'b0000;
                if (q[7:4] == 4'b1001) begin
                    q[7:4] <= 4'b0000;
                    if (q[11:8] == 4'b1001) begin
                        q[11:8] <= 4'b0000;
                        if (q[15:12] == 4'b1001) begin
                            q[15:12] <= 4'b0000;
                        end
                        else begin
                            q[15:12] <= q[15:12] + 1'b1;
                        end
                    end
                    else begin
                        q[11:8] <= q[11:8] + 1'b1;
                    end
                end
                else begin
                    q[7:4] <= q[7:4] + 1'b1;
                end
            end
            else begin
                q[3:0] <= q[3:0] + 1'b1;
            end
        end
    end

    assign ena[1] = (q[3:0] == 4'b1001);
    assign ena[2] = (q[3:0] == 4'b1001) & (q[7:4] == 4'b1001);
    assign ena[3] = (q[3:0] == 4'b1001) & (q[7:4] == 4'b1001) & (q[11:8] == 4'b1001);

endmodule
