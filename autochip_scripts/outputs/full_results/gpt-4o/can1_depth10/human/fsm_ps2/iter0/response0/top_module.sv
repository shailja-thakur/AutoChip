module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    // State Encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;
    
    state_t state, next_state;

    // State Transition Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next State Logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
        endcase
    end

    // Output Logic
    assign done = (state == BYTE3);

endmodule
