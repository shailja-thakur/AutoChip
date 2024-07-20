module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
  
    typedef enum reg [1:0] {IDLE, DETECT_ONE, FLIP_BITS} state_t;
    state_t current_state, next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    
    always @(*) begin
        case (current_state)
            IDLE: 
                if (!x)
                    next_state = DETECT_ONE;
                else
                    next_state = FLIP_BITS;
            DETECT_ONE: 
                if (x)
                    next_state = FLIP_BITS;
                else
                    next_state = DETECT_ONE;
            FLIP_BITS: 
                next_state = FLIP_BITS;
            default: 
                next_state = IDLE;
        endcase
    end
    
    always @(*) begin
        case (current_state)
            IDLE: z = 0;
            DETECT_ONE: z = x;
            FLIP_BITS: z = ~x;
            default: z = 0;
        endcase
    end

endmodule
