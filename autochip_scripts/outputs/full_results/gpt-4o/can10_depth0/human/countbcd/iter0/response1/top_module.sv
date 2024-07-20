module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire inc1, inc2, inc3;
    
    assign ena = {inc3, inc2, inc1};
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
        end else begin
            // Handle ones digit
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                inc1 <= 1;
            end else begin
                q[3:0] <= q[3:0] + 4'd1;
                inc1 <= 0;
            end
            
            // Handle tens digit
            if (inc1) begin
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    inc2 <= 1;
                end else begin
                    q[7:4] <= q[7:4] + 4'd1;
                    inc2 <= 0;
                end
            end else begin
                inc2 <= 0;
            end
            
            // Handle hundreds digit
            if (inc2) begin
                if (q[11:8] == 4'd9) begin
                    q[11:8] <= 4'd0;
                    inc3 <= 1;
                end else begin
                    q[11:8] <= q[11:8] + 4'd1;
                    inc3 <= 0;
                end
            end else begin
                inc3 <= 0;
            end
            
            // Handle thousands digit
            if (inc3) begin
                if (q[15:12] == 4'd9) begin
                    q[15:12] <= 4'd0;
                end else begin
                    q[15:12] <= q[15:12] + 4'd1;
                end
            end
        end
    end
    
endmodule
