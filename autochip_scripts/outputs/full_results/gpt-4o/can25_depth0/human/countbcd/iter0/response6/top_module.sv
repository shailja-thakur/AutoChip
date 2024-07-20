module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);
    
    wire [3:0] digit0, digit1, digit2, digit3;
    wire ena1, ena2, ena3;

    assign ena = {ena3, ena2, ena1};
    assign digit0 = q[3:0];
    assign digit1 = q[7:4];
    assign digit2 = q[11:8];
    assign digit3 = q[15:12];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
        end else begin
            if (digit0 == 9) begin
                q[3:0] <= 4'b0;
                ena1 <= 1;
            end else begin
                q[3:0] <= digit0 + 1;
                ena1 <= 0;
            end
            
            if (ena1) begin
                if (digit1 == 9) begin
                    q[7:4] <= 4'b0;
                    ena2 <= 1;
                end else begin
                    q[7:4] <= digit1 + 1;
                    ena2 <= 0;
                end
            end
            
            if (ena2) begin
                if (digit2 == 9) begin
                    q[11:8] <= 4'b0;
                    ena3 <= 1;
                end else begin
                    q[11:8] <= digit2 + 1;
                    ena3 <= 0;
                end
            end
            
            if (ena3) begin
                if (digit3 == 9) begin
                    q[15:12] <= 4'b0;
                end else begin
                    q[15:12] <= digit3 + 1;
                end
            end
        end
    end
    
endmodule
