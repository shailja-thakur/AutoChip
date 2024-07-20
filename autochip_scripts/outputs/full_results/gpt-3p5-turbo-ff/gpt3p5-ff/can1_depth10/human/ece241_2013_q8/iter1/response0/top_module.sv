module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
reg x_prev;

always @(posedge clk or negedge aresetn)
begin
    if (~aresetn)    // Asynchronous reset
    begin
        state <= 2'b00; // Reset to initial state
        x_prev <= 1'b0; // Reset previous value of x
    end
    else
    begin
        x_prev <= x; // Store the previous value of x

        case(state)
            2'b00:	// State 0
                begin
                    if (x_prev == 1'b1 && x == 1'b0) // Transition from State 0 to State 1
                        state <= 2'b01;
                    else
                        state <= 2'b00; // Stay in State 0
                end

            2'b01:	// State 1
                begin
                    if (x_prev == 1'b0 && x == 1'b1) // Transition from State 1 to State 2
                        state <= 2'b10;
                    else
                        state <= 2'b00; // Go back to State 0 (overlapping sequence)
                end

            2'b10:	// State 2 (Final state)
                begin
                    if (x_prev == 1'b1 && x == 1'b0) // Transition from State 2 to State 1
                        state <= 2'b01;
                    else
                        state <= 2'b00; // Go back to State 0
                end
        endcase
    end
end

always @(*)
begin
    if (state == 2'b10)
        z <= 1'b1; // Output assertion when sequence "101" is detected
    else
        z <= 1'b0; // Output de-assertion for all other states
end

endmodule
