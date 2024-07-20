module top_module (
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'd0,
        DETECT1 = 3'd1,
        DETECT11 = 3'd2,
        DETECT110 = 3'd3,
        DETECT1101 = 3'd4,
        SHIFT_ENA = 3'd5,
        WAIT_COUNTING = 3'd6,
        DONE = 3'd7
    } state_t;

    state_t state, next_state;
    
    // Synchronous state update
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        // Default outputs
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (data)
                    next_state = DETECT1;
                else
                    next_state = IDLE;
            end

            DETECT1: begin
                if (data)
                    next_state = DETECT11;
                else
                    next_state = IDLE;
            end

            DETECT11: begin
                if (data)
                    next_state = DETECT11;
                else
                    next_state = DETECT110;
            end

            DETECT110: begin
                if (data)
                    next_state = DETECT1101;
                else
                    next_state = IDLE;
            end

            DETECT1101: begin
                if (data) begin
                    next_state = SHIFT_ENA;
                end else begin
                    next_state = IDLE;
                end
            end

            SHIFT_ENA: begin
                shift_ena = 1'b1;
                next_state = ( shift_ena ? WAIT_COUNTING : SHIFT_ENA );
            end

            WAIT_COUNTING: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = DONE;
                else
                    next_state = WAIT_COUNTING;
            end

            DONE: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
                else
                    next_state = DONE;
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
