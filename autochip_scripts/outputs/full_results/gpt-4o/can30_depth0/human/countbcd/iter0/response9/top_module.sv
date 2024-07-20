module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire [3:0] d0, d1, d2, d3;
    wire c1, c2, c3;

    assign {d3, d2, d1, d0} = q;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
        end
        else begin
            if (d0 == 4'd9) begin
                q[3:0] <= 4'd0;
                if (d1 == 4'd9) begin
                    q[7:4] <= 4'd0;
                    if (d2 == 4'd9) begin
                        q[11:8] <= 4'd0;
                        if (d3 == 4'd9) begin
                            q[15:12] <= 4'd0;
                        end
                        else begin
                            q[15:12] <= d3 + 4'd1;
                        end
                    end
                    else begin
                        q[11:8] <= d2 + 4'd1;
                    end
                end
                else begin
                    q[7:4] <= d1 + 4'd1;
                end
            end
            else begin
                q[3:0] <= d0 + 4'd1;
            end
        end
    end

    assign c1 = (d0 == 4'd9);
    assign c2 = (d0 == 4'd9 && d1 == 4'd9);
    assign c3 = (d0 == 4'd9 && d1 == 4'd9 && d2 == 4'd9);

    assign ena[1] = c1;
    assign ena[2] = c2;
    assign ena[3] = c3;

endmodule
