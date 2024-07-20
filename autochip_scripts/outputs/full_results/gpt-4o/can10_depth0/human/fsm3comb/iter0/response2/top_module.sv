module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    always @(*) begin
        case (state)
            2'b00: begin // State A
                if (in == 1'b0)
                    next_state = 2'b00; // Stay in A
                else
                    next_state = 2'b01; // Go to B
                out = 1'b0;
            end
            2'b01: begin // State B
                if (in == 1'b0)
                    next_state = 2'b10; // Go to C
                else
                    next_state = 2'b01; // Stay in B
                out = 1'b0;
            end
            2'b10: begin // State C
                if (in == 1'b0)
                    next_state = 2'b00; // Go to A
                else
                    next_state = 2'b11; // Go to D
                out = 1'b0;
            end
            2'b11: begin // State D
                if (in == 1'b0)
                    next_state = 2'b10; // Go to C
                else
                    next_state = 2'b01; // Go to B
                out = 1'b1;
            end
            default: begin
                next_state = 2'b00; // Default to state A
                out = 1'b0; 
            end
        endcase
    end

endmodule
