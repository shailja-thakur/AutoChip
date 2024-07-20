module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always @(*) begin
    case (state)
        2'b00: begin // state A
            out = 0;
            if (in)
                next_state = 2'b01; // Next state B
            else
                next_state = 2'b00; // Next state A
        end
        2'b01: begin // state B
            out = 0;
            if (in)
                next_state = 2'b01; // Next state B
            else
                next_state = 2'b10; // Next state C
        end
        2'b10: begin // state C
            out = 0;
            if (in)
                next_state = 2'b11; // Next state D
            else
                next_state = 2'b00; // Next state A
        end
        2'b11: begin // state D
            out = 1;
            if (in)
                next_state = 2'b01; // Next state B
            else
                next_state = 2'b10; // Next state C
        end
        default: begin
            next_state = 2'b00;
            out = 0;
        end
    endcase
end

endmodule
