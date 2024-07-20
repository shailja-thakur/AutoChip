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

// State machine states
parameter STATE_NONE = 3'b000;
parameter STATE_ABOVE_S3 = 3'b001;
parameter STATE_BETWEEN_S3_S2 = 3'b010;
parameter STATE_BETWEEN_S2_S1 = 3'b011;
parameter STATE_BELOW_S1 = 3'b100;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_NONE;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        case (state)
            STATE_NONE: begin
                if (s == 3'b000)
                    state <= STATE_ABOVE_S3;
            end
            STATE_ABOVE_S3: begin
                if (s == 3'b011)
                    state <= STATE_BETWEEN_S3_S2;
            end
            STATE_BETWEEN_S3_S2: begin
                if (s[2:1] == 2'b01)
                    state <= STATE_BETWEEN_S2_S1;
            end
            STATE_BETWEEN_S2_S1: begin
                if (s[1] == 1'b1)
                    state <= STATE_BELOW_S1;
            end
            STATE_BELOW_S1: begin
                if (s == 3'b000)
                    state <= STATE_ABOVE_S3;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        STATE_NONE: begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b1;
        end
        STATE_ABOVE_S3: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b0;
            dfr = 1'b0;
        end
        STATE_BETWEEN_S3_S2: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b1;
            dfr = 1'b0;
        end
        STATE_BETWEEN_S2_S1: begin
            fr3 = 1'b0;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b0;
        end
        STATE_BELOW_S1: begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b1;
        end
    endcase
end

endmodule
