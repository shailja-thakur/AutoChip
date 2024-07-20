module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

// State transition logic
always @* begin
    case (state)
        2'b00: next_state = (in == 1'b0) ? 2'b00 : 2'b01; // A
        2'b01: next_state = (in == 1'b0) ? 2'b10 : 2'b01; // B
        2'b10: next_state = (in == 1'b0) ? 2'b00 : 2'b11; // C
        2'b11: next_state = (in == 1'b0) ? 2'b10 : 2'b01; // D
        default: next_state = 2'b00;
    endcase
end

// Output logic
always @* begin
    case (state)
        2'b00, 2'b01, 2'b10: out = 1'b0;
        2'b11: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
