module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // State encoding
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;
    
    state_t state, next_state;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            BYTE1: if (in[2])
                       next_state = BYTE2;
                   else
                       next_state = BYTE1;

            BYTE2: next_state = BYTE3;

            BYTE3: next_state = DONE;

            DONE : if (in[2])
                       next_state = BYTE2;
                   else
                       next_state = BYTE1;

            default: next_state = BYTE1;
        endcase
    end

    // Output logic
    assign done = (state == DONE);

endmodule
