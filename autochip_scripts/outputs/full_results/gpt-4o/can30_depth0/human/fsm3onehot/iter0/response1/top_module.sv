module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

always @(*) begin
    case (state)
        4'b0001: begin // State A
            if (in == 0)
                next_state = 4'b0001; // Stay in A
            else
                next_state = 4'b0010; // Go to B
        end
        4'b0010: begin // State B
            if (in == 0)
                next_state = 4'b0100; // Go to C
            else
                next_state = 4'b0010; // Stay in B
        end
        4'b0100: begin // State C
            if (in == 0)
                next_state = 4'b0001; // Go to A
            else
                next_state = 4'b1000; // Go to D
        end
        4'b1000: begin // State D
            if (in == 0)
                next_state = 4'b0100; // Go to C
            else
                next_state = 4'b0010; // Go to B
        end
        default: next_state = 4'b0001; // Default to state A
    endcase
end

assign out = (state == 4'b1000) ? 1 : 0;

endmodule
