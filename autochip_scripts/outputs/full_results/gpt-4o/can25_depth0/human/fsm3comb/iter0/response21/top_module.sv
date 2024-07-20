module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

always @(*) begin
    case (state)
        2'b00: begin // State A
            if (in)
                next_state = 2'b01; // Go to State B
            else
                next_state = 2'b00; // Stay in State A
            out = 1'b0; // Output is 0
        end
        2'b01: begin // State B
            if (in)
                next_state = 2'b01; // Stay in State B
            else
                next_state = 2'b10; // Go to State C
            out = 1'b0; // Output is 0
        end
        2'b10: begin // State C
            if (in)
                next_state = 2'b11; // Go to State D
            else
                next_state = 2'b00; // Go to State A
            out = 1'b0; // Output is 0
        end
        2'b11: begin // State D
            if (in)
                next_state = 2'b01; // Go to State B
            else
                next_state = 2'b10; // Go to State C
            out = 1'b1; // Output is 1
        end
        default: begin
            next_state = 2'b00; // Default to State A
            out = 1'b0; // Default output is 0
        end
    endcase
end

endmodule
