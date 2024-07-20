module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    typedef enum logic [1:0] {
        IDLE = 2'd0,
        BYTE1 = 2'd1,
        BYTE2 = 2'd2,
        BYTE3 = 2'd3
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
        done = 0;
        next_state = state;
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) // First byte start indication
                    next_state = BYTE1;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                done = 1'b1; // Signal done for one cycle
                next_state = IDLE; // Go back to IDLE to find next message
            end
        endcase
    end

endmodule
