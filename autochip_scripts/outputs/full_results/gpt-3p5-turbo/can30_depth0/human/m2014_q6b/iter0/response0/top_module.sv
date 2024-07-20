module top_module(
    input [3:1] y, // Current state input
    input w, // Input signal
    output reg Y2); // Next state output

    always @(*) begin
        case(y)
            3'b000: begin // State A
                if(w) // Input is 1
                    Y2 = 1'b0; // Next state is B
                else // Input is 0
                    Y2 = 1'b0; // Next state is A
            end

            3'b001: begin // State B
                if(w) // Input is 1
                    Y2 = 1'b1; // Next state is D
                else // Input is 0
                    Y2 = 1'b0; // Next state is C
            end

            3'b010: begin // State C
                if(w) // Input is 1
                    Y2 = 1'b0; // Next state is D
                else // Input is 0
                    Y2 = 1'b0; // Next state is E
            end

            3'b011: begin // State D
                if(w) // Input is 1
                    Y2 = 1'b0; // Next state is A
                else // Input is 0
                    Y2 = 1'b0; // Next state is F
            end

            3'b100: begin // State E
                if(w) // Input is 1
                    Y2 = 1'b0; // Next state is D
                else // Input is 0
                    Y2 = 1'b1; // Next state is E
            end

            3'b101: begin // State F
                if(w) // Input is 1
                    Y2 = 1'b0; // Next state is D
                else // Input is 0
                    Y2 = 1'b0; // Next state is C
            end
        endcase  
    end
endmodule
