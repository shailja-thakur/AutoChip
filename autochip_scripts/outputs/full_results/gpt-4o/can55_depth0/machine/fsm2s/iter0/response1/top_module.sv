module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;
    
    state_t current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (j)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (k)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    always @(current_state) begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end
endmodule
