module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

    always_comb begin
        case(state)
            2'b00: begin // State A
                if(in == 1'b1)
                    next_state = 2'b01; // Next state B
                else
                    next_state = 2'b00; // Next state A
            end
            
            2'b01: begin // State B
                if(in == 1'b1)
                    next_state = 2'b01; // Next state B
                else
                    next_state = 2'b10; // Next state C
            end
            
            2'b10: begin // State C
                if(in == 1'b1)
                    next_state = 2'b11; // Next state D
                else
                    next_state = 2'b00; // Next state A
            end
			
            2'b11: begin // State D
                if(in == 1'b1)
                    next_state = 2'b01; // Next state B
                else
                    next_state = 2'b10; // Next state C
            end
        endcase
    end

    assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
