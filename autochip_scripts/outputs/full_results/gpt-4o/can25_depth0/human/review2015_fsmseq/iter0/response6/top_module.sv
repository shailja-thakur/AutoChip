module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'd0,
        S1 = 3'd1,
        S11 = 3'd2,
        S110 = 3'd3,
        FOUND = 3'd4
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (data == 1)
                    next_state = S1;
                else
                    next_state = IDLE;
            end
            S1: begin
                if (data == 1)
                    next_state = S11;
                else
                    next_state = IDLE;
            end
            S11: begin
                if (data == 0)
                    next_state = S110;
                else
                    next_state = S11;
            end
            S110: begin
                if (data == 1)
                    next_state = FOUND;
                else
                    next_state = IDLE;
            end
            FOUND: begin
                next_state = FOUND;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 0;
        end else if (state == FOUND) begin
            start_shifting <= 1;
        end
    end

endmodule
