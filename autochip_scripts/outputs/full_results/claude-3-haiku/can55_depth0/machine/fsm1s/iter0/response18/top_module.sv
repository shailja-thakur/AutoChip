module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // Declare the parameter for the number of states
    parameter NUM_STATES = 2;

    // Declare the state register
    reg [0:0] state;

    // Define the initial state
    initial begin
        state = 1'b1; // Start in state B
    end

    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            1'b0: // State A
                if (in) begin
                    state = 1'b0; // Remain in state A
                end else begin
                    state = 1'b1; // Transition to state B
                end
            1'b1: // State B
                if (in) begin
                    state = 1'b1; // Remain in state B
                end else begin
                    state = 1'b0; // Transition to state A
                end
            default:
                state = 1'b1; // Default to state B
        endcase
    end

    // Sequential logic to update the state register
    always @(posedge clk) begin
        if (reset) begin
            state <= 1'b1; // Reset to state B
        end else begin
            state <= state; // Update state
        end
    end

    // Assign the output based on the state
    assign out = state;

endmodule
