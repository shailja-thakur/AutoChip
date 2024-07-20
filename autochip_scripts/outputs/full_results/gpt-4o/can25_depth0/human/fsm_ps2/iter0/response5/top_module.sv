module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);
    
    // State encoding
    typedef enum logic [1:0] {
        IDLE,
        BYTE1,
        BYTE2,
        BYTE3
    } state_t;
    
    state_t state, next_state;
    
    // Sequential always block: state transitions
    always_ff @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Combinational always block: next state logic
    always_comb begin
        done = 1'b0; // Default value

        case (state)
            IDLE: begin
                if (in[3])
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            
            BYTE1: next_state = BYTE2;
            
            BYTE2: next_state = BYTE3;

            BYTE3: begin
                done = 1'b1;
                if (in[3])
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
    
endmodule
