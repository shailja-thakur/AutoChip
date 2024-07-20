module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State Encoding
    typedef enum logic [1:0] {
        LEVEL_LOW       = 2'b00,
        LEVEL_MID_LOW   = 2'b01,
        LEVEL_MID_HIGH  = 2'b10,
        LEVEL_HIGH      = 2'b11
    } state_t;
    
    // State registers
    state_t state, next_state;
    state_t prev_state;

    // State transition and output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LEVEL_LOW;
            prev_state <= LEVEL_LOW;
            fr1 <= 1;
            fr2 <= 1;
            fr3 <= 1;
            dfr <= 0;
        end else begin
            state <= next_state;
            prev_state <= state;
        end
    end

    always_comb begin
        // Default outputs
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;
        next_state = state; // default transitions to self

        case(state)
            LEVEL_LOW: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                if (s[1]) begin
                    next_state = LEVEL_MID_LOW;
                end
            end
            LEVEL_MID_LOW: begin
                fr1 = 1;
                fr2 = 1;
                if (s[2]) begin
                    next_state = LEVEL_MID_HIGH;
                end else if (~s[1]) begin
                    next_state = LEVEL_LOW;
                end
            end
            LEVEL_MID_HIGH: begin
                fr1 = 1;
                if (s[3]) begin
                    next_state = LEVEL_HIGH;
                end else if (~s[2]) begin
                    next_state = LEVEL_MID_LOW;
                end
            end
            LEVEL_HIGH: begin
                if (~s[3]) begin
                    next_state = LEVEL_MID_HIGH;
                end
            end
        endcase
        
        // Supplemental flow rate logic
        if (state > prev_state) begin
            dfr = 1;
        end
    end
endmodule
