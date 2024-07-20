module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    typedef enum logic[1:0] {
        IDLE = 2'd0,
        BYTE1 = 2'd1,
        BYTE2 = 2'd2,
        BYTE3 = 2'd3
    } state_t;
    
    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always_comb begin
        next_state = current_state;
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
            end

            BYTE1: next_state = BYTE2;

            BYTE2: next_state = BYTE3;

            BYTE3: begin
                next_state = IDLE;
                done = 1'b1;
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
