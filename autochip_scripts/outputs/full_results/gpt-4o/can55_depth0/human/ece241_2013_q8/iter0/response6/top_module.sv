module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00,  // Initial state
        S1 = 2'b01,  // First '1' detected
        S2 = 2'b10   // '10' detected
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S0: begin
                if (x) begin
                    next_state = S1;
                    z = 0;
                end else begin
                    next_state = S0;
                    z = 0;
                end
            end

            S1: begin
                if (x) begin
                    next_state = S1;
                    z = 0;
                end else begin
                    next_state = S2;
                    z = 0;
                end
            end

            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1;  // Sequence '101' detected
                end else begin
                    next_state = S0;
                    z = 0;
                end
            end

            default: begin
                next_state = S0;
                z = 0;
            end
        endcase
    end

    // Sequential state update and reset logic
    always @(negedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

endmodule
