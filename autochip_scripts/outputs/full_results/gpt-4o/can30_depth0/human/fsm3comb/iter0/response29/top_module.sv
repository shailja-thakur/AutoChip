module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

always @(*) begin
    case (state)
        2'b00: begin // State A
            if (in)
                next_state = 2'b01; // B
            else
                next_state = 2'b00; // A
        end
        2'b01: begin // State B
            if (in)
                next_state = 2'b01; // B
            else
                next_state = 2'b10; // C
        end
        2'b10: begin // State C
            if (in)
                next_state = 2'b11; // D
            else
                next_state = 2'b00; // A
        end
        2'b11: begin // State D
            if (in)
                next_state = 2'b01; // B
            else
                next_state = 2'b10; // C
        end
        default: next_state = 2'b00; // default to state A
    endcase
end

assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Output is 1 in state D, else 0

endmodule
