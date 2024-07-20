module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always @(*) begin
    case (state)
        2'b00: begin // State A
            next_state = (in == 0) ? 2'b00 : 2'b01; // A or B
            out = 0;
        end
        2'b01: begin // State B
            next_state = (in == 0) ? 2'b10 : 2'b01; // C or B
            out = 0;
        end
        2'b10: begin // State C
            next_state = (in == 0) ? 2'b00 : 2'b11; // A or D
            out = 0;
        end
        2'b11: begin // State D
            next_state = (in == 0) ? 2'b10 : 2'b01; // C or B
            out = 1;
        end
        default: begin
            next_state = 2'b00; // Default to State A
            out = 0;
        end
    endcase
end

endmodule
