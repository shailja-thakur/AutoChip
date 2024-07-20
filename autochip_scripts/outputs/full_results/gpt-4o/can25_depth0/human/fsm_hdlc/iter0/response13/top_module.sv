module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum {
        STATE_IDLE,
        STATE_0,
        STATE_01,
        STATE_011,
        STATE_0111,
        STATE_01111,
        STATE_011111,
        STATE_0111111,
        STATE_ERROR
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset)
            state <= STATE_IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            STATE_IDLE: next_state = in ? STATE_0 : STATE_IDLE;
            STATE_0: next_state = in ? STATE_01 : STATE_IDLE;
            STATE_01: next_state = in ? STATE_011 : STATE_IDLE;
            STATE_011: next_state = in ? STATE_0111 : STATE_IDLE;
            STATE_0111: next_state = in ? STATE_01111 : STATE_IDLE;
            STATE_01111: next_state = in ? STATE_011111 : STATE_IDLE;
            STATE_011111: next_state = in ? STATE_0111111 : STATE_IDLE; // stay in STATE_0111111 until the input is zero
            STATE_0111111: next_state = in ? STATE_ERROR : STATE_IDLE;
            STATE_ERROR: next_state = STATE_ERROR; // stay in error state
            default: next_state = STATE_IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            disc <= 0; 
            flag <= 0;
            err <= 0;
        end
        else begin
            disc <= 0;
            flag <= 0;
            err <= 0;
            case (next_state)
                STATE_011111: disc <= ~in; // Discard bit if next input is 0 after 011111
                STATE_0111110: disc <= 1;
                STATE_01111110: flag <= 1;
                STATE_ERROR: err <= 1;
            endcase
        end
    end

endmodule
