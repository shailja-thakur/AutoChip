module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    typedef enum logic [1:0] {IDLE, BYTE1, BYTE2, BYTE3} state_t;
    state_t state, next_state;

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // State transition logic
    always_comb begin
        next_state = state;
        done = 1'b0;  // default
        case(state)
            IDLE: if (in[3] == 1) next_state = BYTE1;
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: begin
                next_state = IDLE;
                done = 1'b1;
            end
        endcase
    end

endmodule
