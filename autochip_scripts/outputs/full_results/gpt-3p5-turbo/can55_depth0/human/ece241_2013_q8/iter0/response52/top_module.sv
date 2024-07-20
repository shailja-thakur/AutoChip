module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

parameter S0 = 2'd0; // Initial state
parameter S1 = 2'd1; // First '1' detected
parameter S2 = 2'd2; // '01' detected
parameter S3 = 2'd3; // '101' detected

// Transition logic
always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= S0; // Reset state
    end else begin
        state <= next_state; // Update state
    end
end

// Output logic
always @(state, x) begin
    z = 0; // Default value
    
    case (state)
        S0: begin // Initial state
            if (!x) begin
                next_state = S0; // Stay in the current state
            end else begin
                next_state = S1; // Go to state S1
            end
        end
        
        S1: begin // First '1' detected
            if (x) begin
                next_state = S2; // Go to state S2
            end else begin
                next_state = S1; // Stay in the current state
            end
        end
        
        S2: begin // '01' detected
            if (x) begin
                next_state = S2; // Stay in the current state
            end else begin
                next_state = S3; // Go to state S3
            end
        end
        
        S3: begin // '101' detected
            next_state = S0; // Go back to the initial state
            z = 1; // Set output signal to logic 1
        end
    endcase
end

endmodule
