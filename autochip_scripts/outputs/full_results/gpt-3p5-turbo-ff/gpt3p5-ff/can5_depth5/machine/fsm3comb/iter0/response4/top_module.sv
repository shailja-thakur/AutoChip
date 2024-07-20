module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

    always_comb begin
        case(state)
            2'b00: // State A
                begin
                    if(in) // Transition to B
                        next_state = 2'b01;
                    else // Stay in A
                        next_state = 2'b00;
                end
                
            2'b01: // State B
                begin
                    if(in) // Stay in B
                        next_state = 2'b01;
                    else // Transition to C
                        next_state = 2'b10;
                end
                
            2'b10: // State C
                begin
                    if(in) // Transition to D
                        next_state = 2'b11;
                    else // Transition to A
                        next_state = 2'b00;
                end
                
            2'b11: // State D
                begin
                    if(in) // Transition to B
                        next_state = 2'b01;
                    else // Transition to C
                        next_state = 2'b10;
                end
        endcase
    end

    always @(*) begin
        if(state == 2'b11) // Output is high when in state D
            out = 1'b1;
        else
            out = 1'b0;
    end

endmodule
