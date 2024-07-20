module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    always @(*) begin
        case (state)
            2'b00: begin // State A
                if (in == 1'b0)
                    next_state = 2'b00; // Stay in State A
                else
                    next_state = 2'b01; // Move to State B
                out = 1'b0; // Output for State A is 0
            end
            2'b01: begin // State B
                if (in == 1'b0)
                    next_state = 2'b10; // Move to State C
                else
                    next_state = 2'b01; // Stay in State B
                out = 1'b0; // Output for State B is 0
            end
            2'b10: begin // State C
                if (in == 1'b0)
                    next_state = 2'b00; // Move to State A
                else
                    next_state = 2'b11; // Move to State D
                out = 1'b0; // Output for State C is 0
            end
            2'b11: begin // State D
                if (in == 1'b0)
                    next_state = 2'b10; // Move to State C
                else
                    next_state = 2'b01; // Move to State B
                out = 1'b1; // Output for State D is 1
            end
            default: begin
                next_state = 2'b00; // Default to State A
                out = 1'b0; // Default output
            end
        endcase
    end

endmodule
