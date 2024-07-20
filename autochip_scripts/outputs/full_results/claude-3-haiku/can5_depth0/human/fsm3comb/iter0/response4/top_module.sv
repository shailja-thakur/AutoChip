module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

always @(*) begin
    case (state)
        2'b00: begin // State A
            next_state = in ? 2'b01 : 2'b00; // A -> B, A -> A
            out = 1'b0; // Output 0
        end
        2'b01: begin // State B
            next_state = in ? 2'b01 : 2'b10; // B -> B, B -> C
            out = 1'b0; // Output 0
        end
        2'b10: begin // State C
            next_state = in ? 2'b11 : 2'b00; // C -> D, C -> A
            out = 1'b0; // Output 0
        end
        2'b11: begin // State D
            next_state = in ? 2'b01 : 2'b10; // D -> B, D -> C
            out = 1'b1; // Output 1
        end
    endcase
end

endmodule
