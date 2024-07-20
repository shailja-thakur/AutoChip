module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S1   = 3'b001,
        S11  = 3'b010,
        S110 = 3'b011,
        S1101 = 3'b100
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state; // Default state stays the same
        case (current_state)
            IDLE: begin
                if (data) begin
                    next_state = S1;
                end
            end
            S1: begin
                if (data) begin
                    next_state = S11;
                end else begin
                    next_state = IDLE;
                end
            end
            S11: begin
                if (data) begin
                    next_state = S11;
                end else begin
                    next_state = S110;
                end
            end
            S110: begin
                if (data) begin
                    next_state = S1101;
                end else begin
                    next_state = IDLE;
                end
            end
            S1101: begin
                start_shifting = 1'b1; // Set start_shifting high and stay in this state
                next_state = S1101; // Stay in this state
            end
        endcase
    end
endmodule
