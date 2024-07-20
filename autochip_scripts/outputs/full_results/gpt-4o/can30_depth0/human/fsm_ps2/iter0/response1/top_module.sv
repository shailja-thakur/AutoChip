module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        WAIT_FOR_START = 2'b00,
        BYTE1_RECEIVED = 2'b01,
        BYTE2_RECEIVED = 2'b10,
        BYTE3_RECEIVED = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk) begin
        if (reset)
            state <= WAIT_FOR_START;
        else
            state <= next_state;
    end

    // State machine logic
    always_comb begin
        // Default values
        next_state = state;
        done = 0;
        
        case (state)
            WAIT_FOR_START: begin
                if (in[3] == 1) begin
                    next_state = BYTE1_RECEIVED;
                end
            end
            
            BYTE1_RECEIVED: begin
                next_state = BYTE2_RECEIVED;
            end
            
            BYTE2_RECEIVED: begin
                next_state = BYTE3_RECEIVED;
            end
            
            BYTE3_RECEIVED: begin
                done = 1;
                if (in[3] == 1) begin
                    next_state = BYTE1_RECEIVED;
                end else begin
                    next_state = WAIT_FOR_START;
                end
            end
        endcase
    end

endmodule
