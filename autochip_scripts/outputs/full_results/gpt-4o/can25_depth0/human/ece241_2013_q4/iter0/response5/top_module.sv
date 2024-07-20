module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // Possible states
    typedef enum logic [2:0] {
        LOW,            // Below s[1]
        BETWEEN_LOW_MID,  // Between s[2] and s[1]
        BETWEEN_MID_HIGH, // Between s[3] and s[2]
        HIGH            // Above s[3]
    } state_t;

    state_t current_state, next_state;
    logic was_lower;
    
    // State transition logic
    always @(*) begin
        case(current_state)
            LOW: begin
                if (s[3])
                    next_state = HIGH;
                else if (s[2])
                    next_state = BETWEEN_MID_HIGH;
                else if (s[1])
                    next_state = BETWEEN_LOW_MID;
                else
                    next_state = LOW;
            end
            BETWEEN_LOW_MID: begin
                if (s[3])
                    next_state = HIGH;
                else if (s[2])
                    next_state = BETWEEN_MID_HIGH;
                else if (s[1])
                    next_state = BETWEEN_LOW_MID;
                else
                    next_state = LOW;
            end
            BETWEEN_MID_HIGH: begin
                if (s[3])
                    next_state = HIGH;
                else if (s[2])
                    next_state = BETWEEN_MID_HIGH;
                else if (s[1])
                    next_state = BETWEEN_LOW_MID;
                else
                    next_state = LOW;
            end
            HIGH: begin
                if (s[3])
                    next_state = HIGH;
                else if (s[2])
                    next_state = BETWEEN_MID_HIGH;
                else if (s[1])
                    next_state = BETWEEN_LOW_MID;
                else
                    next_state = LOW;
            end
        endcase
    end
    
    // State registers
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW;
            was_lower <= 1'b1;
        end
        else begin
            if (current_state != next_state)
                was_lower <= (current_state < next_state);
            current_state <= next_state;
        end
    end
    
    // Output logic
    always @(*) begin
        fr1 = 1'b0;
        fr2 = 1'b0;
        fr3 = 1'b0;
        dfr = 1'b0;
        
        case(current_state)
            LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
            end
            BETWEEN_LOW_MID: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (was_lower) dfr = 1'b1;
            end
            BETWEEN_MID_HIGH: begin
                fr1 = 1'b1;
                if (was_lower) dfr = 1'b1;
            end
            HIGH: begin
                // No flow rate outputs asserted
            end
        endcase
    end
endmodule
