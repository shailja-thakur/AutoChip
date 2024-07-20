module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } state_t;

    state_t state, next_state;
    
    // State transition
    always_ff @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in[3])
                    next_state = BYTE_1;
                else
                    next_state = IDLE;
            end
            
            BYTE_1: begin
                next_state = BYTE_2;
            end
            
            BYTE_2: begin
                next_state = BYTE_3;
            end
            
            BYTE_3: begin
                done = 1'b1;
                if (in[3])
                    next_state = BYTE_1;
                else
                    next_state = IDLE;
            end
        endcase
    end
endmodule
