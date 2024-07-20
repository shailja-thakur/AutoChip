module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State declaration
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    // State register
    state_t current_state, next_state;

    // State transitions
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_B: begin
                if (in) 
                    next_state = STATE_B;
                else 
                    next_state = STATE_A;
            end
            STATE_A: begin
                if (in) 
                    next_state = STATE_A;
                else 
                    next_state = STATE_B;
            end
            default: begin
                next_state = STATE_B;
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            out <= 1'b1;
        end else begin
            case (current_state)
                STATE_B: out <= 1'b1;
                STATE_A: out <= 1'b0;
                default: out <= 1'b1;
            endcase
        end
    end
endmodule
