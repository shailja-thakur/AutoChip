module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
    
    // State declaration
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B;  // Asynchronous reset to state B
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        case(state)
            STATE_A: begin
                if (in == 0) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
                out = 0;
            end
            STATE_B: begin
                if (in == 0) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
                out = 1;
            end
            default: begin
                next_state = STATE_B;  // Should not occur, set default to B
                out = 1;
            end
        endcase
    end

endmodule
