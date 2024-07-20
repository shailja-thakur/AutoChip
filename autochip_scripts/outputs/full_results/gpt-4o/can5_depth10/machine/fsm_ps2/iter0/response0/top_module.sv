module top_module (
    input  clk,
    input  [7:0] in,
    input  reset,
    output done
);
    // State Encoding
    typedef enum logic [1:0] {
        BYTE1 = 2'd0,
        BYTE2 = 2'd1,
        BYTE3 = 2'd2,
        DONE  = 2'd3
    } state_t;
    
    state_t state, next_state;

    // Next State Logic
    always @(*) begin
        case(state)
            BYTE1: begin
                if (in[2] == 1)
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end

            BYTE2: begin
                next_state = BYTE3;
            end

            BYTE3: begin
                next_state = DONE;
            end

            DONE: begin
                if (in[2] == 1)
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end

            default: next_state = BYTE1;
        endcase
    end

    // State Transitions
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Output Logic
    assign done = (state == DONE);

endmodule
