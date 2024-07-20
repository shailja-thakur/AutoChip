module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum reg [1:0] {
        LOW = 2'b00,
        MID_LOW = 2'b01,
        MID_HIGH = 2'b10,
        HIGH = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg prev_s1, prev_s2, prev_s3;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            prev_s1 <= 1'b0;
            prev_s2 <= 1'b0;
            prev_s3 <= 1'b0;
        end else begin
            state <= next_state;
            prev_s1 <= s[1];
            prev_s2 <= s[2];
            prev_s3 <= s[3];
        end
    end

    always @(*) begin
        fr1 = 1'b0;
        fr2 = 1'b0;
        fr3 = 1'b0;
        dfr = 1'b0;
        next_state = state;

        case (state)
            LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
                if (s[1])
                    next_state = MID_LOW;
            end
            MID_LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (s[2])
                    next_state = MID_HIGH;
                else if (!s[1])
                    next_state = LOW;
            end
            MID_HIGH: begin
                fr1 = 1'b1;
                if (s[3])
                    next_state = HIGH;
                else if (!s[2])
                    next_state = MID_LOW;
            end
            HIGH: begin
                if (!s[3])
                    next_state = MID_HIGH;
            end
        endcase

        if (prev_s1 == 1'b0 && s[1] == 1'b1) || (prev_s2 == 1'b0 && s[2] == 1'b1) || (prev_s3 == 1'b0 && s[3] == 1'b1) begin
            dfr = 1'b1;
        end
    end
endmodule
