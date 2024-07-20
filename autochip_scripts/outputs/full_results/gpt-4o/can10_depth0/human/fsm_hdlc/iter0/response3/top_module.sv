module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum logic [2:0] {
        IDLE   = 3'b000, // Initial state, acting as if previous input was 0
        S1     = 3'b001, // State after seeing first 0
        S2     = 3'b010, // 01 detected
        S3     = 3'b011, // 011 detected
        S4     = 3'b100, // 0111 detected
        S5     = 3'b101, // 01111 detected
        S6     = 3'b110, // 011111 detected
        FLAG   = 3'b111  // 0111111 detected (Transition to error, flag, or discard)
    } state_t;

    reg [2:0] state, next_state;
    
    // State transition logic
    always @(*) begin
        next_state = state; // Default stay in same state
        disc = 0;
        flag = 0;
        err = 0;
        
        case(state)
            IDLE:   if (in) next_state = S1;
            S1:     if (in) next_state = S2;
                    else next_state = IDLE;
            S2:     if (in) next_state = S3;
                    else next_state = IDLE;
            S3:     if (in) next_state = S4;
                    else next_state = IDLE;
            S4:     if (in) next_state = S5;
                    else next_state = IDLE;
            S5:     if (in) next_state = S6;
                    else next_state = IDLE;
            S6:     if (in) next_state = FLAG;
                    else begin
                        disc = 1;
                        next_state = IDLE;
                    end
            FLAG:   if (in) err = 1;
                    else begin
                        flag = 1;
                        next_state = IDLE;
                    end
            default: next_state = IDLE;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

endmodule
