module top_module(
    input clk,
    input reset,
    output reg [2:0] ena,
    output reg [15:0] q
);

    reg [2:0] count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
            ena <= 3'b0;
            count <= 3'b0;
        end else begin
            if (count == 3'b0) begin
                if (q[3:0] == 4'b1001) begin
                    q[3:0] <= 4'b0000;
                    ena[0] <= 1'b1;
                    count <= 3'b1;
                end else begin
                    q[3:0] <= q[3:0] + 1;
                end
            end else if (count == 3'b1) begin
                if (q[7:4] == 4'b1001) begin
                    q[7:4] <= 4'b0000;
                    ena[1] <= 1'b1;
                    count <= 3'b2;
                end else begin
                    q[7:4] <= q[7:4] + 1;
                end
            end else if (count == 3'b2) begin
                if (q[11:8] == 4'b1001) begin
                    q[11:8] <= 4'b0000;
                    ena[2] <= 1'b1;
                    count <= 3'b0;
                end else begin
                    q[11:8] <= q[11:8] + 1;
                end
            end
        end
    end
endmodule
