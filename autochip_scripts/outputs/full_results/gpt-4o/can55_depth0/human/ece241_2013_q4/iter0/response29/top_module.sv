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
        LOW_STATE,
        MID_LOW_STATE,
        MID_HIGH_STATE,
        HIGH_STATE
    } state_t;
    
    state_t current_state, next_state;
    reg prev_level_higher;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW_STATE;
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
            prev_level_higher <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state;
        // Default values
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;

        case (current_state)
            LOW_STATE: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                // Transition
                if (s[1])
                    next_state = MID_LOW_STATE;
            end
            MID_LOW_STATE: begin
                fr2 = 1'b1;
                fr1 = 1'b1;
                // Transition
                if (s[2])
                    next_state = MID_HIGH_STATE;
                else if (!s[1])
                    next_state = LOW_STATE;
            end
            MID_HIGH_STATE: begin
                fr1 = 1'b1;
                // Transition
                if (s[3])
                    next_state = HIGH_STATE;
                else if (!s[2])
                    next_state = MID_LOW_STATE;
            end
            HIGH_STATE: begin
                // No flow
                // Transition
                if (!s[3])
                    next_state = MID_HIGH_STATE;
            end
        endcase

        // Determine if previous level was lower
        if (current_state == MID_LOW_STATE || current_state == LOW_STATE)
            prev_level_higher = (current_state == MID_LOW_STATE && next_state == MID_HIGH_STATE) || (current_state == LOW_STATE && next_state == MID_LOW_STATE);
        
        // Open the supplemental flow valve if the previous level was lower
        if (prev_level_higher && (current_state != LOW_STATE)) begin
            dfr = 1'b1;
        end
    end
endmodule
