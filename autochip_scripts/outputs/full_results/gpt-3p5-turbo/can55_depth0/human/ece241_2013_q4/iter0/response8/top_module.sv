module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [3:1] prev_s;
reg [1:0] state;

parameter IDLE = 2'b00;
parameter ABOVE_S3 = 2'b01;
parameter BETWEEN_S3_S2 = 2'b10;
parameter BETWEEN_S2_S1 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        case (state)
            IDLE: begin
                if (s[1] && !s[2] && !s[3])
                    state <= BETWEEN_S2_S1;
                else if (!s[1] && s[2] && !s[3])
                    state <= BETWEEN_S3_S2;
                else if (!s[1] && !s[2] && s[3])
                    state <= ABOVE_S3;
                else
                    state <= IDLE;
            end
            ABOVE_S3: begin
                if (!s[3])
                    state <= BETWEEN_S3_S2;
            end
            BETWEEN_S3_S2: begin
                if (s[1] && !s[2] && !s[3])
                    state <= BETWEEN_S2_S1;
                else if (s[3] && !s[2])
                    state <= ABOVE_S3;
            end
            BETWEEN_S2_S1: begin
                if (!s[1])
                    state <= ABOVE_S3;
            end
        endcase
        
        case (state)
            IDLE: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
            ABOVE_S3: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;   
            end
            BETWEEN_S3_S2: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;   
            end
            BETWEEN_S2_S1: begin
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b0;   
            end
        endcase
    end
end

always @(posedge clk) begin
    prev_s <= s;
end

endmodule
