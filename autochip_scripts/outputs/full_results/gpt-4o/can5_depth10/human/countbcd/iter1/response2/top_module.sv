module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 16'd0;
        end else begin
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

    always @(*) begin
        ena[1] = (q[3:0] == 4'd9);
        ena[2] = (ena[1] && q[7:4] == 4'd9);
        ena[3] = (ena[2] && q[11:8] == 4'd9);
    end
    
endmodule
