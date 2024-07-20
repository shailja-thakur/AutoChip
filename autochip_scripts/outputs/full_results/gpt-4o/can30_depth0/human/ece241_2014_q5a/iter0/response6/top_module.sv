module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    typedef enum logic [1:0] {
        S0, // Waiting for input and reset state
        S1  // Process inversion
    } state_t;

    state_t state, next_state;
    logic invert; // Invert signal

    // Next state logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
            invert <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // State transition logic
    always_comb begin
        case (state)
            S0: begin
                if (x) begin
                    next_state = S1;
                    invert = 1'b1;
                end else begin
                    next_state = S0;
                    invert = 1'b0;
                end
            end
            S1: begin
                next_state = S1;
                invert = 1'b1;
            end
            default: begin
                next_state = S0;
                invert = 1'b0;
            end
        endcase
    end

    // Output logic (Moore)
    assign z = invert ? ~x : x;

endmodule
