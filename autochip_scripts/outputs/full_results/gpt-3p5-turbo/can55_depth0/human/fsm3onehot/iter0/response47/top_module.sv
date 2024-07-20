module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

always @ (state or in) begin
    case (state)
        4'b0001: begin // A
            if (in)
                next_state = 4'b0010; // B
            else
                next_state = 4'b0001; // A
            out = 1'b0;
        end
        4'b0010: begin // B
            if (in)
                next_state = 4'b0010; // B
            else
                next_state = 4'b0100; // C
            out = 1'b0;
        end
        4'b0100: begin // C
            if (in)
                next_state = 4'b0001; // A
            else
                next_state = 4'b1000; // D
            out = 1'b0;
        end
        4'b1000: begin // D
            if (in)
                next_state = 4'b0100; // C
            else
                next_state = 4'b0010; // B
            out = 1'b1;
        end
        default: begin
            next_state = 4'b0000; // No state transition
            out = 1'b0; // No output
        end
    endcase
end

endmodule
