module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    // State registers
    state_t state, next_state;

    // State transition on clock edge with reset handling
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
                next_state = STATE_A;  // Default state in case of invalid state
            end
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_A: out = 0;
            STATE_B: out = 1;
            default: out = 0;
        endcase
    end

endmodule
