module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);
    // State Encoding
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t state, state_next;

    // State Register
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= state_next;
    end

    // Next State Logic
    always_comb begin
        state_next = state;
        done = 1'b0;
        
        case (state)
            BYTE1: begin
                if (in[2] == 1'b1)
                    state_next = BYTE2;
            end

            BYTE2: begin
                state_next = BYTE3;
            end

            BYTE3: begin
                state_next = DONE;
            end

            DONE: begin
                done = 1'b1;
                if (in[2] == 1'b0)
                    state_next = BYTE1;
                else
                    state_next = BYTE2;
            end

            default: state_next = BYTE1;
        endcase
    end

endmodule
