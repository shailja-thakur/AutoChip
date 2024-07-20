module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t state, next_state;
    logic [1:0] byte_cnt;

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
                if (in[3] == 1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end

            BYTE1: 
                next_state = BYTE2;
                
            BYTE2: 
                next_state = BYTE3;
                
            BYTE3: 
                if (in[3] == 1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
                
            default: 
                next_state = IDLE;
        endcase
    end

    // Output logic
    always_comb begin
        done = (state == BYTE3) ? 1 : 0;
    end

endmodule
