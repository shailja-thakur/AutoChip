module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        S_IDLE = 2'b00,
        S_BYTE1 = 2'b01,
        S_BYTE2 = 2'b10,
        S_BYTE3 = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S_IDLE: begin
                if (in[3] == 1) 
                    next_state = S_BYTE1;
                else 
                    next_state = S_IDLE;
            end
            S_BYTE1: next_state = S_BYTE2;
            S_BYTE2: next_state = S_BYTE3;
            S_BYTE3: next_state = S_IDLE;
            default: next_state = S_IDLE;
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= S_IDLE;
        else 
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            done <= 0;
        else if (state == S_BYTE3)
            done <= 1;
        else
            done <= 0;
    end

endmodule
