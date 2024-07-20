module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // State after receiving '1'
        S2 = 2'b10  // State after receiving '10'
    } state_t;

    state_t state, next_state;

    // State transition logic (sequential)
    always_ff @(negedge aresetn or posedge clk) begin
        if (~aresetn)
            state <= S0; // Async reset
        else
            state <= next_state;
    end

    // Next state logic (combinational)
    always_comb begin
        case (state)
            S0: if (x) next_state = S1;
                else next_state = S0;
            S1: if (~x) next_state = S2;
                else next_state = S1;
            S2: if (x) next_state = S1;
                else next_state = S0;
            default: next_state = S0; // default state
        endcase
    end

    // Output logic (combinational)
    always_ff @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            z <= 1'b0; // Async reset
        else begin
            case (state)
                S0: z <= 1'b0;
                S1: z <= 1'b0;
                S2: z <= x ? 1'b1 : 1'b0;
                default: z <= 1'b0; // default case
            endcase
        end
    end

endmodule
