module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0000;
            ena <= 3'b000;
        end else begin
            if (ena[3]) begin
                if (q[3:0] < 9) begin
                    q[3:0] <= q[3:0] + 4'b1;
                end else begin
                    q[3:0] <= 4'b0000;
                    if (q[7:4] < 9) begin
                        q[7:4] <= q[7:4] + 4'b1;
                    end else begin
                        q[7:4] <= 4'b0000;
                        if (q[11:8] < 9) begin
                            q[11:8] <= q[11:8] + 4'b1;
                        end else begin
                            q[11:8] <= 4'b0000;
                            if (q[15:12] < 9) begin
                                q[15:12] <= q[15:12] + 4'b1;
                            end else begin
                                q[15:12] <= 4'b0000;
                            end
                        end
                    end
                end
            end else begin
                q <= q;
            end
            ena <= ena;
        end
    end
    
endmodule
