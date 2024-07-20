module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: if (x) next_state = STATE_B; else next_state = STATE_A;
            STATE_B: if (x) next_state = STATE_E; else next_state = STATE_B;
            STATE_C: if (x) next_state = STATE_B; else next_state = STATE_C;
            STATE_D: if (x) next_state = STATE_C; else next_state = STATE_B;
            STATE_E: if (x) next_state = STATE_E; else next_state = STATE_D;
            default: next_state = STATE_A; // Default state should be A
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            z <= 1'b0;
        else begin
            case (current_state)
                STATE_D, STATE_E: z <= 1'b1;
                default: z <= 1'b0;
            endcase
        end
    end
endmodule
