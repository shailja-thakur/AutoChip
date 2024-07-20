module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

always @(*) begin
    case (state)
        4'b0001: // State A
            begin
                if (in == 0)
                    next_state = 4'b0001; // A
                else
                    next_state = 4'b0010; // B
                out = 0;
            end
        4'b0010: // State B
            begin
                if (in == 0)
                    next_state = 4'b0100; // C
                else
                    next_state = 4'b0010; // B
                out = 0;
            end
        4'b0100: // State C
            begin
                if (in == 0)
                    next_state = 4'b0001; // A
                else
                    next_state = 4'b1000; // D
                out = 0;
            end
        4'b1000: // State D
            begin
                if (in == 0)
                    next_state = 4'b0100; // C
                else
                    next_state = 4'b0010; // B
                out = 1;
            end
        default:
            begin
                next_state = 4'b0001; // A
                out = 0;
            end
    endcase
end

endmodule
