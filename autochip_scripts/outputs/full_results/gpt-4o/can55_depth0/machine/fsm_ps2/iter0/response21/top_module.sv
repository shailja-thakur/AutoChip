module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // Define states
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            BYTE1: begin
                if (in[2])
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE: begin
                if (in[2])
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            default: next_state = BYTE1;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            done <= 0;
        else if (state == DONE)
            done <= 1;
        else
            done <= 0;
    end

endmodule
