module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;
    
    state_t current_state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (current_state)
            STATE_A: next_state = (in == 1'b0) ? STATE_B : STATE_A;
            STATE_B: next_state = (in == 1'b0) ? STATE_A : STATE_B;
            default: next_state = STATE_B; // Default to state B
        endcase
    end

    // State flip-flops with asynchronous reset (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_B; // Initial state is B when reset is high
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic (combinational)
    always @(*) begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b1; // Default to state B output
        endcase
    end

endmodule
