module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always @(*) begin
    case (state)
        2'b00: begin // state A
            next_state = in ? 2'b01 : 2'b00; // A -> B, A
            out = 1'b0;
        end
        2'b01: begin // state B
            next_state = in ? 2'b01 : 2'b10; // B -> B, C
            out = 1'b0;
        end
        2'b10: begin // state C
            next_state = in ? 2'b11 : 2'b00; // C -> D, A
            out = 1'b0;
        end
        2'b11: begin // state D
            next_state = in ? 2'b01 : 2'b10; // D -> B, C
            out = 1'b1;
        end
        default: begin
            next_state = 2'b00; // default to state A
            out = 1'b0;
        end
    endcase
end

endmodule
