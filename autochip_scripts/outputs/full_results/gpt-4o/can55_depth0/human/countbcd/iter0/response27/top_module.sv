module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    reg [3:0] cnt0, cnt1, cnt2, cnt3;
    
    assign ena[1] = (cnt0 == 4'd9);
    assign ena[2] = (ena[1] && cnt1 == 4'd9);
    assign ena[3] = (ena[2] && cnt2 == 4'd9);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            cnt0 <= 4'd0;
            cnt1 <= 4'd0;
            cnt2 <= 4'd0;
            cnt3 <= 4'd0;
            q <= 16'b0;
        end else begin
            if (cnt0 == 4'd9) begin
                cnt0 <= 4'd0;
                
                if (cnt1 == 4'd9) begin
                    cnt1 <= 4'd0;
                    
                    if (cnt2 == 4'd9) begin
                        cnt2 <= 4'd0;
                        
                        if (cnt3 == 4'd9) begin
                            cnt3 <= 4'd0;
                        end else begin
                            cnt3 <= cnt3 + 4'd1;
                        end
                    end else begin
                        cnt2 <= cnt2 + 4'd1;
                    end
                end else begin
                    cnt1 <= cnt1 + 4'd1;
                end
            end else begin
                cnt0 <= cnt0 + 4'd1;
            end
            q <= {cnt3, cnt2, cnt1, cnt0};
        end
    end
endmodule
