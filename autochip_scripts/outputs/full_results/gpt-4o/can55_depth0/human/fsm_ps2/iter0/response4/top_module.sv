module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3]) 
                    next_state = BYTE1; // Found the start of a message
                else 
                    next_state = IDLE;
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = in[3] ? BYTE1 : IDLE; // Look for the start of the next message, but prioritize resuming to IDLE to reset state if not immediately found.
            default: next_state = IDLE;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) 
            state <= IDLE;
        else 
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            done <= 0;
        else if (state == BYTE3 && next_state == IDLE)
            done <= 1;
        else
            done <= 0;
    end

endmodule
