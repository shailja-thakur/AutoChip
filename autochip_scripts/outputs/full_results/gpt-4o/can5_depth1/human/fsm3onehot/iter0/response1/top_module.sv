module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

always @(*) begin
    // Default values to avoid latches
    next_state = 4'b0000;
    out = 0;

    case (state)
        4'b0001: begin // State A
            if (in == 0)
                next_state = 4'b0001; // A
            else
                next_state = 4'b0010; // B
            out = 0;
        end

        4'b0010: begin // State B
            if (in == 0)
                next_state = 4'b0100; // C
            else
                next_state = 4'b0010; // B
            out = 0;
        end

        4'b0100: begin // State C
            if (in == 0)
                next_state = 4'b0001; // A
            else
                next_state = 4'b1000; // D
            out = 0;
        end

        4'b1000: begin // State D
            if (in == 0)
                next_state = 4'b0100; // C
            else
                next_state = 4'b0010; // B
            out = 1;
        end

        default: begin
            next_state = 4'b0001; // Default to state A
            out = 0;
        end
    endcase
end

endmodule
