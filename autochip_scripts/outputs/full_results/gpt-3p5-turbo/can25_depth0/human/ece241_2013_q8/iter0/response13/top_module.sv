module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [1:0] state;
    reg x_prev;

    // Define state values
    parameter s0 = 2'b00; // Initial state
    parameter s1 = 2'b01; // State after '1'
    parameter s2 = 2'b10; // State after '10'

    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= s0; // Reset to initial state
            z <= 0; // Reset output
        end
        else begin
            case (state)
                s0: begin // State 0
                    if (x == 1'b1)
                        state <= s1;
                    else
                        state <= s0;
                end
                s1: begin // State 1
                    if (x == 1'b0)
                        state <= s0;
                    else if (x == 1'b1)
                        state <= s2;
                end
                s2: begin // State 2
                    if (x == 1'b1)
                        state <= s1;
                    else if (x == 1'b0)
                        state <= s0;
                end
                default: state <= s0; // Default state
            endcase

            if (state == s2 && x_prev == 1'b1)
                z <= 1;
            else
                z <= 0;

            x_prev <= x;
        end
    end

endmodule
