module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always @(*) begin
    case (state)
        2'b00: begin // State A
            next_state = in ? 2'b01 : 2'b00; // Next state A or B
            out = 1'b0; // Output 0
        end
        2'b01: begin // State B
            next_state = in ? 2'b01 : 2'b10; // Next state B or C
            out = 1'b0; // Output 0
        end
        2'b10: begin // State C
            next_state = in ? 2'b11 : 2'b00; // Next state D or A
            out = 1'b0; // Output 0
        end
        2'b11: begin // State D
            next_state = in ? 2'b01 : 2'b10; // Next state B or C
            out = 1'b1; // Output 1
        end
    endcase
end

endmodule
