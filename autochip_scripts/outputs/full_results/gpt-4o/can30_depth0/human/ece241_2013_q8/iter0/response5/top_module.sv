module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S0 = 2'b00, // Initial/Reset state
        S1 = 2'b01, // State after reading '1'
        S2 = 2'b10  // State after reading '10'
    } state_t;

    state_t current_state, next_state;

    // Sequential part: State transition
    always @(negedge aresetn or posedge clk) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Combinational part: Next state logic and output logic
    always @(*) begin
        z = 0; // Default output
        case (current_state)
            S0: begin
                if (x == 1)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (x == 0)
                    next_state = S2;
                else
                    next_state = S1;
            end

            S2: begin
                if (x == 1) begin
                    next_state = S1;
                    z = 1;
                end
                else
                    next_state = S0;
            end

            default: next_state = S0;
        endcase
    end

endmodule
