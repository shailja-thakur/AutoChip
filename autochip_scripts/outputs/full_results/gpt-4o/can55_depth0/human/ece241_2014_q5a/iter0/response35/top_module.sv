module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    typedef enum reg [1:0] {
        STATE_IDLE = 2'b00,
        STATE_INVERT = 2'b01,
        STATE_COPY = 2'b10
    } state_t;
    
    reg state, next_state;
    
    // FSM state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_IDLE;
        else
            state <= next_state;
    end
    
    // FSM next state logic and output logic
    always @(*) begin
        case (state)
            STATE_IDLE: begin
                z = x;
                next_state = x ? STATE_INVERT : STATE_IDLE;
            end
            STATE_INVERT: begin
                z = ~x;
                next_state = STATE_COPY;
            end
            STATE_COPY: begin
                z = x;
                next_state = STATE_COPY; // Remain in STATE_COPY as we just copy the remaining bits
            end
            default: begin
                z = x;
                next_state = STATE_IDLE;
            end
        endcase
    end
    
endmodule
