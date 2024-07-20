module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'd0,
        BYTE1 = 2'd1,
        BYTE2 = 2'd2,
        BYTE3 = 2'd3
    } state_t;
    
    state_t state, next_state;

    // Output logic
    assign done = (state == BYTE3);

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            IDLE: begin
                if (in[3])
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
                if (in[3])
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
