module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Declare states using localparam
    localparam [1:0] S0 = 2'b00, // Initial state
                     S1 = 2'b01, // State after seeing '1'
                     S2 = 2'b10; // State after seeing '10'

    reg [1:0] state, next_state;

    // State Transition Logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Next State and Output Logic
    always @(*) begin
        // Default assignment
        next_state = state;
        z = 1'b0;

        case (state)
            S0: begin
                if (x) next_state = S1;
            end
            S1: begin
                if (!x) next_state = S2;
                else next_state = S1;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1;
                end
                else next_state = S0;
            end
        endcase
    end
endmodule
