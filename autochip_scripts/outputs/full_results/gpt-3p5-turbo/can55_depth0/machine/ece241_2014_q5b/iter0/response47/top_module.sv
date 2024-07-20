module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    // Define state machine states
    parameter A = 0;
    parameter B = 1;
    
    // Define state register
    reg [1:0] state;
    
    // Next state and output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset state to A
            state <= A;
        end else begin
            // Determine state based on current state and input x
            case (state)
                A: begin
                    if (x) begin
                        // Set state to B if x is 1
                        state <= B;
                    end
                end
                B: begin
                    // State remains B
                end
            endcase
        end
    end
    
    // Output logic
    always @* begin
        if (state == A && x) begin
            // Set output z to 1 when state is A and x is 1
            z = 1;
        end else if (state == B && !x) begin
            // Set output z to 1 when state is B and x is 0
            z = 1;
        end else begin
            // Set output z to 0 otherwise
            z = 0;
        end
    end

endmodule
