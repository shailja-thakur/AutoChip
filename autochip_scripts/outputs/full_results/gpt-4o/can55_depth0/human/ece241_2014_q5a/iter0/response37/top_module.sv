module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00,  // Initial state, Waiting for Reset release
        S1 = 2'b01,  // Copying input bits directly until first '1'
        S2 = 2'b10   // Invert all bits after first '1'
    } state_t;
    state_t state, next_state;
    
    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
            z <= 0;
        end else begin
            state <= next_state;
            case (state)
                S0: z <= 0;
                S1: z <= x;
                S2: z <= ~x;
            endcase
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = S1;
            S1: if (x) next_state = S2; else next_state = S1;
            S2: next_state = S2;
            default: next_state = S0;
        endcase
    end
    
    // Reset transition to start state S1
    always @(posedge areset) begin
        if (areset) begin
            state <= S0;
        end
    end

endmodule
