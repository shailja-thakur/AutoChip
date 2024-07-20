module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire inc_1, inc_2, inc_3;

    assign inc_1 = (q[3:0] == 4'd9);
    assign inc_2 = (q[7:4] == 4'd9) && inc_1;
    assign inc_3 = (q[11:8] == 4'd9) && inc_2;
    
    assign ena = {inc_3, inc_2, inc_1};
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0;
        end else begin
            // Increment ones digit
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    if (q[11:8] == 4'd9) begin
                        q[11:8] <= 4'd0;
                        if (q[15:12] == 4'd9) begin
                            q[15:12] <= 4'd0;
                        end else begin
                            q[15:12] <= q[15:12] + 4'd1;
                        end
                    end else begin
                        q[11:8] <= q[11:8] + 4'd1;
                    end
                end else begin
                    q[7:4] <= q[7:4] + 4'd1;
                end
            end else begin
                q[3:0] <= q[3:0] + 4'd1;
            end
        end
    end
endmodule
