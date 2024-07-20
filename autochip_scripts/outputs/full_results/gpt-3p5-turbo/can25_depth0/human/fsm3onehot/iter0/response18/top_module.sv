module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    always @* begin
        case(state)
            4'b0001: begin // State A
                next_state = (in) ? 4'b0010 : 4'b0001; // Next state B or A
                out = 1'b0; // Output 0
            end
            
            4'b0010: begin // State B
                next_state = (in) ? 4'b0010 : 4'b0100; // Next state B or C
                out = 1'b0; // Output 0
            end
            
            4'b0100: begin // State C
                next_state = (in) ? 4'b0001 : 4'b1000; // Next state A or D
                out = 1'b0; // Output 0
            end
            
            4'b1000: begin // State D
                next_state = (in) ? 4'b0100 : 4'b0010; // Next state C or B
                out = 1'b1; // Output 1
            end
        endcase
    end

endmodule
