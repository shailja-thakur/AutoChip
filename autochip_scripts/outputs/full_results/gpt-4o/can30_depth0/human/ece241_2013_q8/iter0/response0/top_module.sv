module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S0 = 2'b00,  // Initial state
        S1 = 2'b01,  // Detected '1'
        S2 = 2'b10   // Detected '10'
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= S0;  // Asynchronous reset to initial state
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        z = 0;  // Default value for the output
        case (current_state)
            S0: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S2;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1;  // Sequence "101" detected
                end
                else
                    next_state = S0;
            end
            default: next_state = S0;
        endcase
    end
endmodule
