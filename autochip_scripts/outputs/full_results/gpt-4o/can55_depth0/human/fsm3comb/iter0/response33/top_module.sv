module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

    // Assign next state logic based on the state table
    always @(*) begin
        case (state)
            2'b00: begin // State A
                next_state = (in == 1'b0) ? 2'b00 : 2'b01; // A or B
            end
            2'b01: begin // State B
                next_state = (in == 1'b0) ? 2'b10 : 2'b01; // C or B
            end
            2'b10: begin // State C
                next_state = (in == 1'b0) ? 2'b00 : 2'b11; // A or D
            end
            2'b11: begin // State D
                next_state = (in == 1'b0) ? 2'b10 : 2'b01; // C or B
            end
            default: begin // Default case to handle undefined states
                next_state = 2'b00; // Defaulting to state A
            end
        endcase
    end

    // Assign output logic based on the current state
    always @(*) begin
        case (state)
            2'b00: out = 1'b0; // State A
            2'b01: out = 1'b0; // State B
            2'b10: out = 1'b0; // State C
            2'b11: out = 1'b1; // State D
            default: out = 1'b0; // Default output
        endcase
    end

endmodule
