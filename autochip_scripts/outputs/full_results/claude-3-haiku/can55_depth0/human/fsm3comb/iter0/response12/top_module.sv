module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

always @(*) begin
    case (state)
        2'b00: // State A
            begin
                if (in == 1'b0)
                    next_state = 2'b00; // A
                else
                    next_state = 2'b01; // B
                out = 1'b0;
            end
        2'b01: // State B
            begin
                if (in == 1'b0)
                    next_state = 2'b10; // C
                else
                    next_state = 2'b01; // B
                out = 1'b0;
            end
        2'b10: // State C
            begin
                if (in == 1'b0)
                    next_state = 2'b00; // A
                else
                    next_state = 2'b11; // D
                out = 1'b0;
            end
        2'b11: // State D
            begin
                if (in == 1'b0)
                    next_state = 2'b10; // C
                else
                    next_state = 2'b01; // B
                out = 1'b1;
            end
    endcase
end

endmodule
