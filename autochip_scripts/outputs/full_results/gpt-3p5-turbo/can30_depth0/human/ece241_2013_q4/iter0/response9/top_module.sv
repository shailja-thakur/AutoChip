module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [2:0] state;

parameter ST_IDLE = 0;
parameter ST_ABOVE_S3 = 1;
parameter ST_BETWEEN_S3_S2 = 2;
parameter ST_BETWEEN_S2_S1 = 3;
parameter ST_BELOW_S1 = 4;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= ST_IDLE;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        case (state)
            ST_IDLE: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
                
                if (s[1] && s[2] && s[3])
                    state <= ST_ABOVE_S3;
                else if (s[1] && s[2])
                    state <= ST_BETWEEN_S3_S2;
                else if (s[1])
                    state <= ST_BETWEEN_S2_S1;
                else if (!s[1] && !s[2] && !s[3])
                    state <= ST_BELOW_S1;
            end
            
            ST_ABOVE_S3: begin
                fr3 <= 1'b0;
                
                if (!s[3])
                    state <= ST_BETWEEN_S3_S2;
            end
            
            ST_BETWEEN_S3_S2: begin
                fr1 <= 1'b1;
                fr2 <= 1'b0;
                
                if (!s[2])
                    state <= ST_BETWEEN_S2_S1;
                else if (s[3])
                    state <= ST_ABOVE_S3;
            end
            
            ST_BETWEEN_S2_S1: begin
                fr1 <= 1'b1;
                fr2 <= 1'b1;
                
                if (!s[1])
                    state <= ST_BELOW_S1;
                else if (!s[2])
                    state <= ST_BETWEEN_S3_S2;
            end
            
            ST_BELOW_S1: begin
                fr1 <= 1'b1;
                fr2 <= 1'b1;
                fr3 <= 1'b0;
                dfr <= 1'b0;
                
                if (s[1] || s[2] || s[3])
                    state <= ST_ABOVE_S3;
            end
        endcase
    end
end

endmodule
