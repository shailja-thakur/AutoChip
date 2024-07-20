module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // FSM state declarations
    typedef enum logic [3:0] {
        STATE_IDLE,
        STATE_0,
        STATE_01,
        STATE_011,
        STATE_0111,
        STATE_01111,
        STATE_011111,
        STATE_0111110,
        STATE_0111111,
        STATE_01111111,
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

    // Output logic
    always @(*) begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        // Next state logic
        case (state)
            STATE_IDLE: begin
                if (in)
                    next_state = STATE_0;
                else
                    next_state = STATE_IDLE;
            end
            STATE_0: begin
                if (in)
                    next_state = STATE_IDLE;
                else
                    next_state = STATE_01;
            end
            STATE_01: begin
                if (in)
                    next_state = STATE_011;
                else
                    next_state = STATE_IDLE;
            end
            STATE_011: begin
                if (in)
                    next_state = STATE_0111;
                else
                    next_state = STATE_IDLE;
            end
            STATE_0111: begin
                if (in)
                    next_state = STATE_01111;
                else
                    next_state = STATE_IDLE;
            end
            STATE_01111: begin
                if (in)
                    next_state = STATE_011111;
                else
                    next_state = STATE_IDLE;
            end
            STATE_011111: begin
                if (in)
                    next_state = STATE_0111111;
                else
                    next_state = STATE_0111110;
            end
            STATE_0111110: begin
                disc = 1'b1;
                next_state = in ? STATE_0 : STATE_01;
            end
            STATE_0111111: begin
                if (in)        
                    next_state = STATE_01111111;
                else begin
                    flag = 1'b1;
                    next_state = STATE_IDLE;
                end
            end
            STATE_01111111: begin
                if (in)
                    next_state = STATE_ERROR;
                else
                    err = 1'b1;
                next_state = STATE_IDLE;
            end
            STATE_ERROR: begin
                err = 1'b1;
                next_state = STATE_IDLE;
            end
            default: next_state = STATE_IDLE;
        endcase
    end
    
endmodule
