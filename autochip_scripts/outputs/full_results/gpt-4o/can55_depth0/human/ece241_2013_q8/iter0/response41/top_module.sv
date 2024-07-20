module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        S0 = 2'b00, // No bits detected
        S1 = 2'b01, // '1' detected
        S2 = 2'b10  // '10' detected
    } state_t;

    state_t state, next_state;

    always_ff @(negedge aresetn or posedge clk) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    always_comb begin
        next_state = state;
        z = 0;
        unique case (state)
            S0: begin
                if (x)
                    next_state = S1;
            end
            S1: begin
                if (!x)
                    next_state = S2;
                else
                    next_state = S1;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1; // Output '1' when '101' detected
                end else 
                    next_state = S0;
            end
        endcase
    end
endmodule
