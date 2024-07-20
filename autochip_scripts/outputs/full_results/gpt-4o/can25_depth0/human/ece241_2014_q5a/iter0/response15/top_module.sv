module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State declaration
    typedef enum reg [1:0] {
        S0, // Initial state
        S1, // Invert bits until first '1'
        S2  // After first '1', pass bits unchanged
    } state_t;
    
    state_t state, next_state;

    // Moore state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
            z <= 0;
        end else begin
            state <= next_state;
            z <= output_logic;
        end
    end

    // State transition logic
    always @(*) begin
        case(state)
            S0: begin
                if (x == 1) begin
                    next_state = S2;
                end else begin
                    next_state = S1;
                end
            end
            S1: begin
                if (x == 1) begin
                    next_state = S2;
                end else begin
                    next_state = S1;
                end
            end
            S2: next_state = S2;
            default: next_state = S0;
        endcase
    end

    // Output logic
    reg output_logic;
    always @(*) begin
        case(state)
            S0: output_logic = ~x;
            S1: output_logic = ~x;
            S2: output_logic = x;
            default: output_logic = 0;
        endcase
    end

endmodule
