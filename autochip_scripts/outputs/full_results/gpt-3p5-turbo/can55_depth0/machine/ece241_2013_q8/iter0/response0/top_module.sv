module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Declare state variable
    reg [3:0] state, state_next;

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            // Reset to initial state
            state <= 4'b0000;
        end else begin
            // Assign next state based on current state and input
            case (state)
                4'b0000: state_next = (x == 1) ? 4'b0001 : 4'b0000; // S -> S1 / S -> S
                4'b0001: state_next = (x == 1) ? 4'b0001 : 4'b0010; // S1 -> S1 / S1 -> S10
                4'b0010: state_next = (x == 1) ? 4'b0001 : 4'b0000; // S10 -> S1 / S10 -> S
                default: state_next = 4'b0000; // Default to S
            endcase

            // Assign output based on current state
            case (state)
                4'b0000, 4'b0001: z = 1'b0; // S, S1 -> Output z is always 0
                4'b0010: z = x; // S10 -> Output z is input x
                default: z = 1'b0; // Default to 0
            endcase

            // Update state
            state <= state_next;
        end
    end

endmodule
