module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
            ena <= 0;
        end else begin
            if (q[3:0] == 9) begin
                q[3:0] <= 0;
                q[7:4] <= q[7:4] + 1;
                if (q[7:4] == 10) begin
                    q[7:4] <= 0;
                    q[11:8] <= q[11:8] + 1;
                    if (q[11:8] == 10) begin
                        q[11:8] <= 0;
                        q[15:12] <= q[15:12] + 1;
                        if (q[15:12] == 10) begin
                            q[15:12] <= 0;
                        end
                    end
                end
            end else begin
                q[3:0] <= q[3:0] + 1;
            end

            ena <= {(q[3:0] == 9), (q[7:4] == 9), (q[11:8] == 9)};
        end
    end
endmodule
