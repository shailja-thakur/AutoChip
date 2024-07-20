module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

    typedef enum reg [1:0] {S0, S1} state_t;
    state_t state, next_state;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S0; // Initial state
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0:
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            S1:
                next_state = S1;
            default:
                next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            S0: z = ~x; // Output ~x in state S0
            S1: z = x;   // Output x in state S1
            default: z = 0;
        endcase
    end
    
endmodule
