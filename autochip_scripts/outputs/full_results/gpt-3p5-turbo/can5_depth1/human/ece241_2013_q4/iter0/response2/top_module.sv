module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [3:0] state;
parameter ABV_S3 = 4'b1111;
parameter BTW_S3_S2 = 4'b1100;
parameter BTW_S2_S1 = 4'b1000;
parameter BLW_S1 = 4'b0000;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 4'b0000;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end
    else begin
        case (state)
            ABV_S3: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
                if (s[3] == 1'b0)
                    state <= BTW_S3_S2;
            end
            
            BTW_S3_S2: begin
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b0;
                if ((s[3] == 1'b0) && (s[2] == 1'b0))
                    state <= BTW_S2_S1;
                else if (s[1] == 1'b1)
                    state <= BLW_S1;
            end
            
            BTW_S2_S1: begin
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b0;
                dfr <= 1'b0;
                if (s[1] == 1'b1)
                    state <= BLW_S1;
            end
            
            BLW_S1: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
        endcase
    end
end

endmodule
