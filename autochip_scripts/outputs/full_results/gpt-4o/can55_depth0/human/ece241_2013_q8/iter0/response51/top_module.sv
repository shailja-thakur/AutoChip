module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State declaration
    typedef enum reg [1:0] {S0, S1, S2} state_t;
    state_t current_state, next_state;

    // Output logic
    always @ (posedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // State transition logic
    always @ (*) begin
        // Default values
        next_state = current_state;
        z = 1'b0;
        
        case (current_state)
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
                    z = 1'b1;
                end else
                    next_state = S0;
            end
        endcase
    end

endmodule
