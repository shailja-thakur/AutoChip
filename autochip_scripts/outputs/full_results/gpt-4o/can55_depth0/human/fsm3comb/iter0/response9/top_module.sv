module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    always @(*) begin
        // Default output
        out = 0;

        case (state)
            2'b00: begin // State A
                if (in) 
                    next_state = 2'b01; // A -> B
                else 
                    next_state = 2'b00; // A -> A
                out = 0;
            end
            2'b01: begin // State B
                if (in) 
                    next_state = 2'b01; // B -> B
                else 
                    next_state = 2'b10; // B -> C
                out = 0;
            end
            2'b10: begin // State C
                if (in)
                    next_state = 2'b11; // C -> D
                else 
                    next_state = 2'b00; // C -> A
                out = 0;
            end
            2'b11: begin // State D
                if (in)
                    next_state = 2'b01; // D -> B
                else 
                    next_state = 2'b10; // D -> C
                out = 1;
            end
            default: begin
                next_state = 2'b00;
                out = 0;
            end
        endcase
    end
endmodule
