module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
    
    // State encoding
    typedef enum reg [1:0] {
        STATE_HIGH = 2'b00,     // Above s[3]
        STATE_MIDDLE_UP = 2'b01, // Between s[3] and s[2]
        STATE_MIDDLE_DOWN = 2'b10, // Between s[2] and s[1]
        STATE_LOW = 2'b11       // Below s[1]
    } state_t;
  
    state_t current_state, next_state;
    reg previous_level_was_up; // Track if the previous level was up

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_HIGH: begin
                if (s[3] == 1'b0) begin
                    if (s[2] == 1'b1) 
                        next_state = STATE_MIDDLE_UP;
                    else if (s[1] == 1'b1) 
                        next_state = STATE_MIDDLE_DOWN;
                    else 
                        next_state = STATE_LOW;
                end else begin
                    next_state = STATE_HIGH;
                end
            end
            STATE_MIDDLE_UP: begin
                if (s[2] == 1'b0) begin
                    if (s[1] == 1'b1) 
                        next_state = STATE_MIDDLE_DOWN;
                    else 
                        next_state = STATE_LOW;
                end else if (s[3] == 1'b1) begin
                    next_state = STATE_HIGH;
                end else begin
                    next_state = STATE_MIDDLE_UP;
                end
            end
            STATE_MIDDLE_DOWN: begin
                if (s[1] == 1'b0) begin
                    next_state = STATE_LOW;
                end else if (s[2] == 1'b1 && s[3] == 1'b0) begin
                    next_state = STATE_MIDDLE_UP;
                end else if (s[3] == 1'b1) begin
                    next_state = STATE_HIGH;
                end else begin
                    next_state = STATE_MIDDLE_DOWN;
                end
            end
            STATE_LOW: begin
                if (s[1] == 1'b1) begin
                    next_state = STATE_MIDDLE_DOWN;
                end else begin
                    next_state = STATE_LOW;
                end
            end
            default: next_state = STATE_LOW;
        endcase
    end

    // Track if the previous level was up or down
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            previous_level_was_up <= 1'b0;
        end else if ((current_state == STATE_MIDDLE_UP && next_state == STATE_MIDDLE_DOWN) || 
                     (current_state == STATE_LOW && next_state == STATE_MIDDLE_DOWN)) begin
            previous_level_was_up <= 1'b1;
        end else if ((current_state == STATE_MIDDLE_DOWN && next_state == STATE_MIDDLE_UP) || 
                     (current_state == STATE_HIGH && next_state == STATE_MIDDLE_UP)) begin
            previous_level_was_up <= 1'b0;
        end
    end

    // State output logic
    always @(*) begin
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
        case (current_state)
            STATE_HIGH: begin
                // Do nothing (all flow rates are zero)
            end
            STATE_MIDDLE_UP: begin
                fr1 = 1'b1;
                if (previous_level_was_up) begin
                    dfr = 1'b1;
                end
            end
            STATE_MIDDLE_DOWN: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (previous_level_was_up) begin
                    dfr = 1'b1;
                end
            end
            STATE_LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
            end
        endcase
    end
    
    // Sequential state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_LOW;
        end else begin
            current_state <= next_state;
        end
    end

endmodule
