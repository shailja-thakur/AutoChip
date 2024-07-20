module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

always @(*) begin
    case (state)
        2'b00: // state A
            if (in == 1'b0)
                next_state = 2'b00; // A
            else
                next_state = 2'b01; // B
        2'b01: // state B
            if (in == 1'b0)
                next_state = 2'b10; // C
            else
                next_state = 2'b01; // B
        2'b10: // state C
            if (in == 1'b0)
                next_state = 2'b00; // A
            else
                next_state = 2'b11; // D
        2'b11: // state D
            if (in == 1'b0)
                next_state = 2'b10; // C
            else
                next_state = 2'b01; // B
    endcase
end

assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
