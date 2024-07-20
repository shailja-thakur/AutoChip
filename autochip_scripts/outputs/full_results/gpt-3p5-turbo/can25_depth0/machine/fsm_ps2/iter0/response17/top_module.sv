module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // Declare state register and next state register
    reg [1:0] state, next_state;

    // Declare wire to check the third bit of the input
    wire third_bit;

    // Output register
    reg done_reg;

    // Assign done output signal
    assign done = done_reg;

    // Always block for sequential logic
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            // Reset the state machine
            state <= 2'b00;
            done_reg <= 0;
        end else begin
            // Assign next state based on current state and input
            case (state)
                2'b00: begin
                    // BYTE1 state
                    if (in[2] == 1'b1)
                        next_state <= 2'b01; // Transition to BYTE2 state
                    else
                        next_state <= 2'b00; // Remain in BYTE1 state
                end
                2'b01: begin
                    // BYTE2 state
                    next_state <= 2'b10; // Transition to BYTE3 state
                end
                2'b10: begin
                    // BYTE3 state
                    next_state <= 2'b11; // Transition to DONE state
                end
                2'b11: begin
                    // DONE state
                    if (in[2] == 1'b1)
                        next_state <= 2'b01; // Transition back to BYTE2 state
                    else
                        next_state <= 2'b00; // Transition back to BYTE1 state
                end
                default: next_state <= 2'b00; // Reset to BYTE1 state if unknown state
            endcase
        end
    end

    // Assign current state to next state at the end of the clock cycle
    always @(posedge clk) begin
        state <= next_state;
        done_reg <= (state == 2'b10); // Assert done output signal in DONE state
    end

    // Assign wire to check the third bit of the input
    assign third_bit = in[2];

endmodule
