module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state_reg, next_state;
    reg out_reg, next_out;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state_reg <= 2'd1; // Set initial state to B
        else
            state_reg <= next_state;
    end

    // Output register
    always @(posedge clk) begin
        out_reg <= next_out;
    end

    // Next state logic
    always @(state_reg or in) begin
        case(state_reg)
            2'd0: begin  // State B
                if (in)
                    next_state = 2'd0; // Stay in B
                else
                    next_state = 2'd1; // Transition to A
            end

            2'd1: begin  // State A
                if (in)
                    next_state = 2'd1; // Stay in A
                else
                    next_state = 2'd0; // Transition to B
            end

            default: begin
                next_state = 2'd1; // Default to B state if not B or A
            end
        endcase
    end

    // Next output logic
    always @(state_reg) begin
        case(state_reg)
            2'd0: begin  // State B
                next_out = 1'b1;
            end

            2'd1: begin  // State A
                next_out = 1'b0;
            end

            default: begin
                next_out = 1'b0; // Default to output 0 if not B or A
            end
        endcase
    end

    // Output assignment
    assign out = out_reg;

endmodule
