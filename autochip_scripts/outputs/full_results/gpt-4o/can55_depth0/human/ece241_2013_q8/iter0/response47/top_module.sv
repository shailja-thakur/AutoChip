module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State Encoding
    typedef enum logic [1:0] {
        S0 = 2'd0, // Initial state
        S1 = 2'd1, // State after seeing '1'
        S2 = 2'd2  // State after seeing '10'
    } state_t;
    
    state_t current_state, next_state;

    // Sequential logic: State transitioning with asynchronous reset
    always @(negedge aresetn or posedge clk) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Combinational logic: Next state logic and output logic
    always @(*) begin
        case (current_state)
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
                if (!x) begin
                    next_state = S2;
                    z = 0;
                end else begin
                    next_state = S1;
                    z = 0;
                end
            end

            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1;
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

endmodule
