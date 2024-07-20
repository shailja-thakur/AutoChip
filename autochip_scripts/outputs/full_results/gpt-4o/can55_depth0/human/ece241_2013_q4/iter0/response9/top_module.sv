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
        STATE_LOW = 2'b00,
        STATE_BETWEEN = 2'b01,
        STATE_HIGH = 2'b10
    } state_t;
    
    state_t state, next_state;
    reg next_dfr;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_LOW;
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end else begin
            state <= next_state;
            dfr <= next_dfr;
        end
    end
    
    always_comb begin
        // Default values
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        next_dfr = dfr;
        
        // Next state logic
        case (state)
            STATE_LOW: begin
                if (s[3] == 1) begin
                    next_state = STATE_HIGH;
                    fr3 = 0;
                    fr2 = 0;
                    fr1 = 0;
                end else if (s[2] == 1) begin
                    next_state = STATE_BETWEEN;
                    fr2 = 1;
                    fr1 = 1;
                end else begin
                    next_state = STATE_LOW;
                    fr3 = 1;
                    fr2 = 1;
                    fr1 = 1;
                end
            end
            
            STATE_BETWEEN: begin
                if (s[3] == 1) begin
                    next_state = STATE_HIGH;
                    fr3 = 0;
                    fr2 = 0;
                    fr1 = 0;
                end else if (s[2] == 1) begin
                    next_state = STATE_BETWEEN;
                    fr2 = 1;
                    fr1 = 1;
                end else if (s[1] == 1) begin
                    next_state = STATE_LOW;
                    fr3 = 0;
                    fr2 = 1;
                    fr1 = 1;
                end else begin
                    next_state = STATE_LOW;
                    fr3 = 1;
                    fr2 = 1;
                    fr1 = 1;
                end
                
                if (s[1] == 1 && s[2] == 1 && !dfr) begin
                    next_dfr = 1;
                end else begin
                    next_dfr = 0;
                end
            end
            
            STATE_HIGH: begin
                if (s[3] == 1) begin
                    next_state = STATE_HIGH;
                    fr3 = 0;
                    fr2 = 0;
                    fr1 = 0;
                end else if (s[2] == 1) begin
                    next_state = STATE_BETWEEN;
                    fr2 = 1;
                    fr1 = 1;
                end else if (s[1] == 1) begin
                    next_state = STATE_LOW;
                    fr3 = 0;
                    fr2 = 1;
                    fr1 = 1;
                end else begin
                    next_state = STATE_LOW;
                    fr3 = 1;
                    fr2 = 1;
                    fr1 = 1;
                end
            end
            
            default: begin
                next_state = STATE_LOW;
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 1;
            end
        endcase
    end
    
endmodule
