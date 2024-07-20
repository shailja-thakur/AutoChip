module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic: synchronous
    always @(posedge clk) begin
        if (reset)
            state <= STATE_B;
        else
            state <= next_state;
    end
    
    // Next state logic and output logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (in == 1'b0)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
                out = 1'b0;
            end
            
            STATE_B: begin
                if (in == 1'b0)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
                out = 1'b1;
            end
            
            default: begin
                next_state = STATE_B;
                out = 1'b1;
            end
        endcase
    end
    
endmodule
