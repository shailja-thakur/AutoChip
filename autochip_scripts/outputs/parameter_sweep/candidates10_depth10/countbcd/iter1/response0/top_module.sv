module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk) begin
    if(reset) begin
        q <= 16'd0;
        ena <= 3'b0;
    end else begin
        if(ena[1]) begin
            if(q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                if(ena[2]) begin
                    if(q[7:4] == 4'd9) begin
                        q[7:4] <= 4'd0;
                        if(ena[3]) begin
                            if(q[11:8] == 4'd9) begin
                                q[11:8] <= 4'd0;
                                q[15:12] <= q[15:12] + 4'd1;
                            end else begin
                                q[11:8] <= q[11:8] + 4'd1;
                            end
                        end
                    end else begin
                        q[7:4] <= q[7:4] + 4'd1;
                    end
                end
            end else begin
                q[3:0] <= q[3:0] + 4'd1;
            end
        end
    end
end

endmodule
