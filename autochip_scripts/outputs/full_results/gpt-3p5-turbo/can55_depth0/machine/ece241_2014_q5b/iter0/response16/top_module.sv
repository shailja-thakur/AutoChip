module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define the two states of the state machine
    parameter A = 0;
    parameter B = 1;

    // Declare the state register
    reg [1:0] state;

    // State machine logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A; // Set state to A when areset is asserted
        end else begin
            case (state)
                A: begin
                    if (x) begin
                        state <= B; // Transition to state B if x is 1
                    end else begin
                        state <= A; // Stay in state A if x is 0
                    end
                end
                B: begin
                    state <= B; // Stay in state B
                end
            endcase
        end
    end

    // Output logic
    always @(state or x) begin
        if ((state == A && x) || (state == B && !x)) begin
            z <= 1; // Set z to 1 when conditions are met
        end else begin
            z <= 0; // Set z to 0 otherwise
        end
    end

endmodule
