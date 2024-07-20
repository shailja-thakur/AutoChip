module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    typedef enum logic [2:0] {
        S_IDLE  = 3'b000,
        S_ONE   = 3'b001,
        S_TWO   = 3'b010,
        S_THREE = 3'b011,
        S_FOUR  = 3'b100,
        S_FIVE  = 3'b101,
        S_SIX   = 3'b110,
        S_SEVEN = 3'b111
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S_IDLE:   next_state = in ? S_ONE : S_IDLE;
            S_ONE:    next_state = in ? S_TWO : S_IDLE;
            S_TWO:    next_state = in ? S_THREE : S_IDLE;
            S_THREE:  next_state = in ? S_FOUR : S_IDLE;
            S_FOUR:   next_state = in ? S_FIVE : S_IDLE;
            S_FIVE:   next_state = in ? S_SIX : S_IDLE;
            S_SIX:    next_state = in ? S_SEVEN : S_IDLE;
            S_SEVEN:  next_state = in ? S_SEVEN : S_IDLE;
            default:  next_state = S_IDLE;
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            disc <= 0;
            flag <= 0;
            err <= 0;
            case (state)
                S_SIX: begin
                    if (!in)  // Detected 0111110
                        disc <= 1;
                end
                S_IDLE: begin
                    if (!first_clk && !in && state == S_Six & memory[0] == 1 & memory[1] == 1 & memory[2] == 1  memory[4] == 1& memory[5] == 1) 
                        flag <= 1;	
                end
                S_SEVEN: begin
                    err <= 1;  // Detected 7 or more consecutive 1s
                end
            endcase
        end
    end

endmodule
