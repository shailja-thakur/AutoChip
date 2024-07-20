module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Declare states using localparam
    localparam [1:0] S0 = 2'b00,
                     S1 = 2'b01,
                     S2 = 2'b10;

    reg [1:0] state, next_state;

    // Sequential logic for state transition on the negative edge of the clock
    always @(negedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Combinational logic for next state and output generation
    always @(*) begin
        // Default values
        next_state = state;
        z = 0;

        case (state)
            S0: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S2;
            end

            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1;
                end else
                    next_state = S0;
            end

            default: next_state = S0;
        endcase
    end
endmodule
