module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        WAIT_STOP = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            done <= 0;
        end
        else begin
            state <= next_state;
            if (state == START || state == DATA) begin
                bit_count <= bit_count + 1;
            end
            if (state == STOP)
                done <= 1;
            else
                done <= 0;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state; // Default to same state
        case (state)
            IDLE: begin
                if (in == 0)
                    next_state = START;
            end
            START: begin
                if (in == 0 && bit_count == 1)
                    next_state = DATA;
            end
            DATA: begin
                if (bit_count == 9)
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1)
                    next_state = IDLE;
                else
                    next_state = WAIT_STOP;
            end
            WAIT_STOP: begin
                if (in == 1)
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
