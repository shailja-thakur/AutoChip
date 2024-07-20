module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always @(*) begin
    case (state)
        2'b00: begin // State A
            next_state = (in == 1'b0) ? 2'b00 : 2'b01; // A -> A, B
            out = 1'b0;
        end
        2'b01: begin // State B
            next_state = (in == 1'b0) ? 2'b10 : 2'b01; // B -> C, B
            out = 1'b0;
        end
        2'b10: begin // State C
            next_state = (in == 1'b0) ? 2'b00 : 2'b11; // C -> A, D
            out = 1'b0;
        end
        2'b11: begin // State D
            next_state = (in == 1'b0) ? 2'b10 : 2'b01; // D -> C, B
            out = 1'b1;
        end
        default: begin
            next_state = 2'bxx;
            out = 1'bx;
        end
    endcase
end

endmodule
