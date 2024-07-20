module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    
    // Define the states
    typedef enum logic [1:0] {
        S,
        S1,
        S10
    } state_type;
    
    // Define the current state and next state variables
    reg state_type current_state;
    reg next_state;
    
    always_ff @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            // Asynchronous reset
            current_state <= S;
        end else begin
            // State transition logic
            current_state <= next_state;
        end
    end
    
    always_comb begin
        case (current_state)
            S: begin
                // State S logic
                if (x == 0) begin
                    next_state = S;
                end else begin
                    next_state = S1;
                end
                z = 0;
            end
            S1: begin
                // State S1 logic
                if (x == 0) begin
                    next_state = S10;
                end else begin
                    next_state = S1;
                end
                z = 0;
            end
            S10: begin
                // State S10 logic
                if (x == 0) begin
                    next_state = S;
                end else begin
                    next_state = S1;
                end
                z = x;
            end
            default: begin
                // Default case
                next_state = S;
                z = 0;
            end
        endcase
    end

endmodule
