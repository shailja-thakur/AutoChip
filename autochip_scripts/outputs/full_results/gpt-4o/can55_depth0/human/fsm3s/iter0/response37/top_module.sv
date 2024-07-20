module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
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
    
    // Combinational logic for next state and output
    always @(*) begin
        // Default assignments
        next_state = current_state;
        out = 0;

        case (current_state)
            STATE_A: begin
                if (in) next_state = STATE_B;
                out = 0;
            end
            STATE_B: begin
                if (!in) next_state = STATE_C;
                out = 0;
            end
            STATE_C: begin
                if (in) next_state = STATE_D;
                else next_state = STATE_A;
                out = 0;
            end
            STATE_D: begin
                if (in) next_state = STATE_B;
                else next_state = STATE_C;
                out = 1;
            end
        endcase
    end

endmodule
