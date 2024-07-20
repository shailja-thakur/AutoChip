module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S1 = 3'b001,
        S11 = 3'b010,
        S110 = 3'b011,
        FOUND = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (data == 1'b1)
                    next_state = S1;
                else
                    next_state = IDLE;
            end

            S1: begin
                if (data == 1'b1)
                    next_state = S11;
                else
                    next_state = IDLE;
            end

            S11: begin
                if (data == 1'b0)
                    next_state = S110;
                else
                    next_state = S11;
            end

            S110: begin
                if (data == 1'b1)
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
            start_shifting <= 1'b0;
        end else if (current_state == FOUND) begin
            start_shifting <= 1'b1;
        end
    end
endmodule
