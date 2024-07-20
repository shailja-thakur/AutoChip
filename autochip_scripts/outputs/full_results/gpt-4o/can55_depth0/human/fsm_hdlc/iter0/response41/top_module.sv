module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State Encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100,
        S5 = 3'b101,
        S6 = 3'b110,
        ERR = 3'b111
    } state_t;

    state_t state, next_state;

    // State Transition Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next State Logic
    always_comb begin
        next_state = state;  // Default to no change
        case (state)
            IDLE: 
                if (in) next_state = S1;
            
            S1: 
                if (in) next_state = S2; 
                else next_state = IDLE;
            
            S2: 
                if (in) next_state = S3;
                else next_state = IDLE;
            
            S3: 
                if (in) next_state = S4;
                else next_state = IDLE;
            
            S4: 
                if (in) next_state = S5;
                else next_state = IDLE;
            
            S5: 
                if (in) next_state = S6;
                else next_state = IDLE;
            
            S6: 
                if (in) next_state = ERR;  // More than 6 consecutive 1s
                else next_state = IDLE;
            
            ERR: 
                next_state = IDLE;  // Once in error, reset to IDLE
        endcase
    end

    // Output Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            disc <= 0;
            flag <= 0;
            err <= (state == ERR);

            case (next_state)
                IDLE:
                    if (state == S5 && !in) disc <= 1;  // 0111110 pattern
                S6:
                    if (state == S5 && in) flag <= 1;  // 01111110 pattern
                ERR:
                    if (state == S6 && in) err <= 1;   // 01111111 pattern
            endcase
        end
    end
endmodule
