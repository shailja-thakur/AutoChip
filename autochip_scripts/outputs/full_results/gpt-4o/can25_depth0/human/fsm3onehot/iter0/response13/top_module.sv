module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    always @(*) begin
        case (state)
            4'b0001: // State A
                if (in == 0) begin
                    next_state = 4'b0001; // Stay in state A
                    out = 0;
                end else begin
                    next_state = 4'b0010; // Move to state B
                    out = 0;
                end
            4'b0010: // State B
                if (in == 0) begin
                    next_state = 4'b0100; // Move to state C
                    out = 0;
                end else begin
                    next_state = 4'b0010; // Stay in state B
                    out = 0;
                end
            4'b0100: // State C
                if (in == 0) begin
                    next_state = 4'b0001; // Move to state A
                    out = 0;
                end else begin
                    next_state = 4'b1000; // Move to state D
                    out = 0;
                end
            4'b1000: // State D
                if (in == 0) begin
                    next_state = 4'b0100; // Move to state C
                    out = 1;
                end else begin
                    next_state = 4'b0010; // Move to state B
                    out = 1;
                end
            default: begin
                next_state = 4'b0001; // Default state is A
                out = 0;
            end
        endcase
    end

endmodule
