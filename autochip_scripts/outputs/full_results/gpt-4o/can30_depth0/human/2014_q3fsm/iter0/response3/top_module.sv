module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
    // Define state encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    // State registers
    state_t state, next_state;
    reg [1:0] w_count;  // Counter for 'w = 1'

    // Sequential logic: state transition
    always @(posedge clk) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Combinational logic: next state logic and output logic
    always @* begin
        next_state = state;
        z = 1'b0;  // Default output
        
        case (state)
            STATE_A: begin
                if (s)
                    next_state = STATE_B;
            end
            
            STATE_B: begin
                next_state = STATE_C;
                w_count = 2'b00;
            end
            
            STATE_C: begin
                if (w)
                    w_count = w_count + 1;
                next_state = STATE_D;
            end
            
            STATE_D: begin
                if (w)
                    w_count = w_count + 1;
                if (w_count == 2'b10)
                    z = 1'b1;
                else
                    z = 1'b0;
                next_state = STATE_B;  // Go back to examine next three cycles
            end
        endcase
    end

    // Initialize state
    initial begin
        state = STATE_A;
        w_count = 2'b00;
        z = 1'b0;
    end

endmodule
