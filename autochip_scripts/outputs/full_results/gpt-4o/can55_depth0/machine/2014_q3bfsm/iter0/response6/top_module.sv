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

    // State transition
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (x) next_state = STATE_B;
                else   next_state = STATE_A;
            end
            STATE_B: begin
                if (x) next_state = STATE_E;
                else   next_state = STATE_B;
            end
            STATE_C: begin
                if (x) next_state = STATE_B;
                else   next_state = STATE_C;
            end
            STATE_D: begin
                if (x) next_state = STATE_C;
                else   next_state = STATE_B;
            end
            STATE_E: begin
                if (x) next_state = STATE_E;
                else   next_state = STATE_D;
            end
            default: next_state = STATE_A;
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_D, STATE_E: z = 1'b1;
            default:          z = 1'b0;
        endcase
    end

endmodule
