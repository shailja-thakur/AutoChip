module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);
    // State declaration
    typedef enum logic [1:0] {
        IDLE   = 2'd0,
        BYTE1  = 2'd1,
        BYTE2  = 2'd2,
        BYTE3  = 2'd3
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) 
                    next_state = BYTE1;
                else 
                    next_state = IDLE;
            end
            
            BYTE1: 
                next_state = BYTE2;
            
            BYTE2: 
                next_state = BYTE3;
            
            BYTE3: begin
                done = 1'b1;
                if (in[3] == 1'b1) 
                    next_state = BYTE1;
                else 
                    next_state = IDLE;
            end
            
            default: 
                next_state = IDLE;
        endcase
    end

    // State flip-flops (sequential logic)
    always @(posedge clk) begin
        if (reset) 
            state <= IDLE;
        else 
            state <= next_state;
    end

endmodule
