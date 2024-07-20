module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    always @(*) begin
        case (state)
            4'b0001: begin  // State A
                if (in) 
                    next_state = 4'b0010; // B
                else 
                    next_state = 4'b0001; // A
                out = 1'b0;
            end
            4'b0010: begin  // State B
                if (in) 
                    next_state = 4'b0010; // B
                else 
                    next_state = 4'b0100; // C
                out = 1'b0;
            end
            4'b0100: begin  // State C
                if (in) 
                    next_state = 4'b1000; // D
                else 
                    next_state = 4'b0001; // A
                out = 1'b0;
            end
            4'b1000: begin  // State D
                if (in) 
                    next_state = 4'b0010; // B
                else 
                    next_state = 4'b0100; // C
                out = 1'b1;
            end
            default: begin  // By default go to state A
                next_state = 4'b0001; // A
                out = 1'b0;
            end
        endcase
    end

endmodule
