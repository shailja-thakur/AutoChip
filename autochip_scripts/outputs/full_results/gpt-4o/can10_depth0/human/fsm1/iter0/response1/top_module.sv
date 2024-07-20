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
    
    // Internal state registers
    state_t current_state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (in) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
                out = 1'b0;
            end
            STATE_B: begin
                if (in) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
                out = 1'b1;
            end
            default: begin
                next_state = STATE_B; // Default to state B
                out = 1'b1;
            end
        endcase
    end
    
    // State register logic (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_B;
        end else begin
            current_state <= next_state;
        end
    end
endmodule
