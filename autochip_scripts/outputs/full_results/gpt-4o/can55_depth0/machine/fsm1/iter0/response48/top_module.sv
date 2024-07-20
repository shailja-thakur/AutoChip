module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
    
    // State declarations
    typedef enum logic [0:0] {STATE_A = 1'b0, STATE_B = 1'b1} state_t;
    state_t state, next_state;
    
    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always_comb begin
        case (state)
            STATE_A: begin
                if (in) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                if (in) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
        endcase
    end
    
    // Output signal logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            out <= 1'b1;
        end else begin
            out <= (state == STATE_B);
        end
    end
    
endmodule
