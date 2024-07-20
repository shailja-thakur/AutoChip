module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum logic[2:0] {
        S_IDLE = 3'b000,
        S_ONE = 3'b001,
        S_TWO = 3'b010,
        S_THREE = 3'b011,
        S_FOUR = 3'b100,
        S_FIVE = 3'b101,
        S_SIX = 3'b110,
        S_SEVEN = 3'b111
    } state_t;

    state_t current_state, next_state;

    // Sequential state transition
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S_IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinatorial logic for next state and outputs
    always_comb begin
        // Default outputs
        disc = 0;
        flag = 0;
        err = 0;

        case (current_state)
            S_IDLE: begin
                if (in) next_state = S_ONE;
                else next_state = S_IDLE;
            end
            S_ONE: begin
                if (in) next_state = S_TWO;
                else next_state = S_IDLE;
            end
            S_TWO: begin
                if (in) next_state = S_THREE;
                else next_state = S_IDLE;
            end
            S_THREE: begin
                if (in) next_state = S_FOUR;
                else next_state = S_IDLE;
            end
            S_FOUR: begin
                if (in) next_state = S_FIVE;
                else next_state = S_IDLE;
            end
            S_FIVE: begin
                if (in) next_state = S_SIX;
                else begin
                    next_state = S_IDLE;
                    disc = 1;
                end
            end
            S_SIX: begin
                if (in) next_state = S_SEVEN;
                else begin
                    next_state = S_IDLE;
                    flag = 1;
                end
            end
            S_SEVEN: begin
                if (in) begin
                    next_state = S_SEVEN;
                    err = 1;
                end else begin
                    next_state = S_IDLE;
                    flag = 1;
                end
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

endmodule
