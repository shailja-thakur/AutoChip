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
        LOW,       // Below s[1]
        MIDDLE1,   // Between s[2] and s[1]
        MIDDLE2,   // Between s[3] and s[2]
        HIGH       // Above s[3]
    } state_t;
    
    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        // Default values
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;

        case (state)
            LOW: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 1;
                if (s[1])      next_state = MIDDLE1;
                else           next_state = LOW;
            end
            MIDDLE1: begin
                fr1 = 1;
                fr2 = 1;
                if (s[2]) begin
                    next_state = MIDDLE2;
                    dfr = 1; // Supplemental flow valve opened due to increased level
                end else if (!s[1]) begin
                    next_state = LOW;
                end else begin
                    next_state = MIDDLE1;
                end
            end
            MIDDLE2: begin
                fr1 = 1;
                if (s[3]) begin
                    next_state = HIGH;
                    dfr = 1; // Supplemental flow valve opened due to increased level
                end else if (!s[2]) begin
                    next_state = MIDDLE1;
                end else begin
                    next_state = MIDDLE2;
                end
            end
            HIGH: begin
                if (!s[3]) begin
                    next_state = MIDDLE2;
                end else begin
                    next_state = HIGH;
                end
            end
            default: next_state = LOW;
        endcase
    end
endmodule
