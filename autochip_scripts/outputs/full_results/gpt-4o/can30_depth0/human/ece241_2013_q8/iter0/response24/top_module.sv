module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S0 = 2'b00,  // Initial state
        S1 = 2'b01,  // State after detecting '1'
        S2 = 2'b10   // State after detecting '10'
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        // Default outputs
        z = 1'b0;

        case (current_state)
            S0: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
            end

            S1: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S2;
                end
            end

            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1;
                end else begin
                    next_state = S0;
                end
            end

            default: next_state = S0;
        endcase
    end

endmodule
