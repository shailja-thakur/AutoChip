module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

// State transition logic
always @(state, in)
begin
    case (state)
        2'b00: if (in) next_state = 2'b01; else next_state = 2'b00; // A
        2'b01: if (in) next_state = 2'b01; else next_state = 2'b10; // B
        2'b10: if (in) next_state = 2'b11; else next_state = 2'b00; // C
        2'b11: if (in) next_state = 2'b01; else next_state = 2'b10; // D
        default: next_state = 2'b00;
    endcase
end

// Output logic
always @(state)
begin
    case (state)
        2'b00: out = 1'b0; // A
        2'b01: out = 1'b0; // B
        2'b10: out = 1'b0; // C
        2'b11: out = 1'b1; // D
        default: out = 1'b0;
    endcase
end

endmodule
