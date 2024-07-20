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
reg [2:0] state;
reg [2:0] next_state;

parameter IDLE = 3'b000;
parameter ABOVE_S3 = 3'b001;
parameter BETWEEN_S3_S2 = 3'b010;
parameter BETWEEN_S2_S1 = 3'b011;

always @(posedge clk) begin
    if (reset) begin
        prev_s <= 3'b000;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b0;
        state <= IDLE;
    end else begin
        prev_s <= s;
        state <= next_state;
    end
end

always @* begin
    case (state)
        IDLE: begin
            if (s[3]) begin
                next_state <= ABOVE_S3;
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end else if (s[2]) begin
                next_state <= BETWEEN_S3_S2;
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end else if (s[1]) begin
                next_state <= BETWEEN_S2_S1;
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                
                if (prev_s[2] > s[2]) begin
                    dfr <= 1'b1;
                end else begin
                    dfr <= 1'b0;
                end
            end else begin
                next_state <= IDLE;
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
        end
        ABOVE_S3: begin
            if (!s[3]) begin
                next_state <= BETWEEN_S3_S2;
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
        end
        BETWEEN_S3_S2: begin
            if (s[3]) begin
                next_state <= ABOVE_S3;
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end else if (!s[2]) begin
                next_state <= IDLE;
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
        end
        BETWEEN_S2_S1: begin
            if (s[2]) begin
                next_state <= BETWEEN_S3_S2;
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end else if (!s[1]) begin
                next_state <= IDLE;
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
        end
    endcase
end

endmodule
