module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum logic [1:0] {
        LOW = 2'b00,
        MID = 2'b01,
        HIGH = 2'b10,
        ABOVE = 2'b11
    } state_t;

    state_t state, next_state;
    state_t prev_state;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            prev_state <= LOW;
            fr1 <= 1;
            fr2 <= 1;
            fr3 <= 1;
            dfr <= 1;
        end else begin
            state <= next_state;
            prev_state <= state;
        end
    end

    always_comb begin
        // Default values
        next_state = state;
        fr1 = 0;
        fr2 = 0;
        fr3 = 0;
        dfr = 0;
        
        case (state)
            LOW: begin
                if (s[1] && s[2] && s[3])
                    next_state = ABOVE;
                else if (s[1] && s[2])
                    next_state = MID;
                else if (s[1])
                    next_state = HIGH;
                else
                    next_state = LOW;
                    
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                
                if (prev_state == MID || prev_state == HIGH || prev_state == ABOVE)
                    dfr = 1;
            end
            MID: begin
                if (s[1] && s[2] && s[3])
                    next_state = ABOVE;
                else if (s[1] && s[2])
                    next_state = MID;
                else if (s[1])
                    next_state = HIGH;
                else
                    next_state = LOW;
                    
                fr1 = 1;
                
                if (prev_state == LOW)
                    dfr = 1;
            end
            HIGH: begin
                if (s[1] && s[2] && s[3])
                    next_state = ABOVE;
                else if (s[1] && s[2])
                    next_state = MID;
                else if (s[1])
                    next_state = HIGH;
                else
                    next_state = LOW;
                    
                fr1 = 1;
                fr2 = 1;
                
                if (prev_state == LOW)
                    dfr = 1;
            end
            ABOVE: begin
                if (s[1] && s[2] && s[3])
                    next_state = ABOVE;
                else if (s[1] && s[2])
                    next_state = MID;
                else if (s[1])
                    next_state = HIGH;
                else
                    next_state = LOW;
            end
            default: begin
                next_state = LOW;
            end
        endcase
    end
endmodule
