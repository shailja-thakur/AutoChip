module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    // Internal connections
    wire ena1, ena2, ena3;

    // Enable conditions
    assign ena1 = (q[3:0] == 4'd9);
    assign ena2 = (q[7:4] == 4'd9) & ena1;
    assign ena3 = (q[11:8] == 4'd9) & ena2;

    assign ena = {ena3, ena2, ena1};

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'h0000;
        end else begin
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                if (ena1) begin
                    if (q[7:4] == 4'd9) begin
                        q[7:4] <= 4'd0;
                        if (ena2) begin
                            if (q[11:8] == 4'd9) begin
                                q[11:8] <= 4'd0;
                                if (ena3) begin
                                    if (q[15:12] == 4'd9) begin
                                        q[15:12] <= 4'd0;
                                    end else begin
                                        q[15:12] <= q[15:12] + 1;
                                    end
                                end else begin
                                    q[11:8] <= q[11:8] + 1;
                                end
                            end else begin
                                q[11:8] <= q[11:8] + 1;
                            end
                        end else begin
                            q[7:4] <= q[7:4] + 1;
                        end
                    end else begin
                        q[7:4] <= q[7:4] + 1;
                    end
                end else begin
                    q[3:0] <= q[3:0] + 1;
                end
            end else begin
                q[3:0] <= q[3:0] + 1;
            end
        end
    end

endmodule
