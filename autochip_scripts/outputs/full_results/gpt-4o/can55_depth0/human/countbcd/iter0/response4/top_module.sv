module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire c1, c2, c3;
    
    assign ena[1] = c1;
    assign ena[2] = c2;
    assign ena[3] = c3;
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 16'b0;
        end
        else begin
            q[3:0] <= (q[3:0] == 4'd9) ? 4'd0 : q[3:0] + 1;
            c1 <= (q[3:0] == 4'd9);

            if (c1) begin
                q[7:4] <= (q[7:4] == 4'd9) ? 4'd0 : q[7:4] + 1;
                c2 <= (q[7:4] == 4'd9);
            end
            else begin
                c2 <= 1'b0;
            end

            if (c1 && c2) begin
                q[11:8] <= (q[11:8] == 4'd9) ? 4'd0 : q[11:8] + 1;
                c3 <= (q[11:8] == 4'd9);
            end
            else begin
                c3 <= 1'b0;
            end

            if (c1 && c2 && c3) begin
                q[15:12] <= (q[15:12] == 4'd9) ? 4'd0 : q[15:12] + 1;
            end
        end
    end

endmodule
