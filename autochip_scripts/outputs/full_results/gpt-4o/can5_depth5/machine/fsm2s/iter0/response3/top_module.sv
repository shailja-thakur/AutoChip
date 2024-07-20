module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State definition
    typedef enum reg [0:0] {STATE_A, STATE_B} state_t;
    state_t state, next_state;

    // Initialize the state to STATE_A
    initial begin
        state = STATE_A;
    end

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (j) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end

            STATE_B: begin
                if (k) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end

            default: begin
                next_state = STATE_A; // Default state
            end
        endcase
    end

    // Output logic
    always @(state) begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b0; // Default output
        endcase
    end

endmodule
