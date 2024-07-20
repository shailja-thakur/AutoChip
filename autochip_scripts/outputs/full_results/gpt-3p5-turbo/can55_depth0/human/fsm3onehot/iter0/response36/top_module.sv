module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    always @(*) begin
        case (state)
            4'b0001: begin // State A
                if (in)
                    next_state = 4'b0010; // Next state in = 1, B
                else
                    next_state = 4'b0001; // Next state in = 0, A
                out = 1'b0; // Output = 0
            end
            
            4'b0010: begin // State B
                if (in)
                    next_state = 4'b0010; // Next state in = 1, B
                else
                    next_state = 4'b0100; // Next state in = 0, C
                out = 1'b0; // Output = 0
            end
            
            4'b0100: begin // State C
                if (in)
                    next_state = 4'b0001; // Next state in = 1, A
                else
                    next_state = 4'b1000; // Next state in = 0, D
                out = 1'b0; // Output = 0
            end
            
            4'b1000: begin // State D
                if (in)
                    next_state = 4'b0100; // Next state in = 1, C
                else
                    next_state = 4'b0010; // Next state in = 0, B
                out = 1'b1; // Output = 1
            end
        endcase
    end

endmodule
