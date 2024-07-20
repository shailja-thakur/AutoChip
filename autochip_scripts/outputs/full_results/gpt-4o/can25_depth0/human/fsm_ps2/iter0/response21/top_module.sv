module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (in[3])
                    next_state = BYTE_1;
                else
                    next_state = IDLE;
            end
            BYTE_1: next_state = BYTE_2;
            BYTE_2: next_state = BYTE_3;
            BYTE_3: begin
                next_state = IDLE;
                done = 1'b1;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
