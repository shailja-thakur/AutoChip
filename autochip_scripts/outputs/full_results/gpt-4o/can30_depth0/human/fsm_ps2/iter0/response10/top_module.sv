module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // FSM state declaration
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;
    
    state_t state, next_state;
    
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    always @(*) begin
        // Default values
        done = 0;
        next_state = state;
        
        case (state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            
            BYTE1: begin
                next_state = BYTE2;
            end
            
            BYTE2: begin
                next_state = BYTE3;
            end
            
            BYTE3: begin
                done = 1;
                if (in[3] == 1'b1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end

endmodule
