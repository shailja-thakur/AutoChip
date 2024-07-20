module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    always @(*) begin
        // Default values
        next_state = 4'b0000;
        out = 0;

        case (state)
            4'b0001: begin // State A
                next_state = (in == 1'b0) ? 4'b0001 : 4'b0010; // A -> A (in=0), A -> B (in=1)
                out = 1'b0;
            end

            4'b0010: begin // State B
                next_state = (in == 1'b0) ? 4'b0100 : 4'b0010; // B -> C (in=0), B -> B (in=1)
                out = 1'b0;
            end

            4'b0100: begin // State C
                next_state = (in == 1'b0) ? 4'b0001 : 4'b1000; // C -> A (in=0), C -> D (in=1)
                out = 1'b0;
            end

            4'b1000: begin // State D
                next_state = (in == 1'b0) ? 4'b0100 : 4'b0010; // D -> C (in=0), D -> B (in=1)
                out = 1'b1;
            end

            default: begin
                next_state = 4'b0001; // Default to state A
                out = 1'b0;
            end
        endcase
    end
endmodule
