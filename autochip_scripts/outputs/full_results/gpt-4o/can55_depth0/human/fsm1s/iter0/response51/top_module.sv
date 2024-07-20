module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);
    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;
    
    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            STATE_B: next_state = (in) ? STATE_B : STATE_A;
            STATE_A: next_state = (in) ? STATE_A : STATE_B;
            default: next_state = STATE_B;
        endcase
    end
    
    // State register (sequential)
    always @(posedge clk) begin
        if (reset)
            state <= STATE_B;
        else
            state <= next_state;
    end
    
	// Output logic
    always @(*) begin
        case (state)
            STATE_B: out = 1;
            STATE_A: out = 0;
            default: out = 1; // default state should be consistent with reset state
        endcase
    end
endmodule
