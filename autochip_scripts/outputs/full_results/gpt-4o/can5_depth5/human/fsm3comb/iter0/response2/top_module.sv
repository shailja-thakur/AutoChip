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
                next_state = 2'b00; // Next state A
            else
                next_state = 2'b01; // Next state B
            out = 1'b0; // Output for state A
        end
        2'b01: begin // State B
            if (in == 1'b0)
                next_state = 2'b10; // Next state C
            else
                next_state = 2'b01; // Next state B
            out = 1'b0; // Output for state B
        end
        2'b10: begin // State C
            if (in == 1'b0)
                next_state = 2'b00; // Next state A
            else
                next_state = 2'b11; // Next state D
            out = 1'b0; // Output for state C
        end
        2'b11: begin // State D
            if (in == 1'b0)
                next_state = 2'b10; // Next state C
            else
                next_state = 2'b01; // Next state B
            out = 1'b1; // Output for state D
        end
        default: begin
            next_state = 2'b00; // Default to state A
            out = 1'b0;
        end
    endcase
end

endmodule
