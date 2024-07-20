module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    always @(*) begin
        case (1'b1) // Use one-hot coding for switching between states
            y[1]: begin // State A
                Y2 = y[1] & w;        // Y2 will be 1 if the next state is B
                Y4 = 1'b0;            // Y4 will remain 0
            end
            y[2]: begin // State B
                Y2 = y[2] & ~w;       // Y2 will be 1 if the next state is C
                Y4 = y[2] & w;        // Y4 will be 1 if the next state is D
            end
            y[3]: begin // State C
                Y2 = y[3] & ~w;       // Y2 will be 1 if the next state is E
                Y4 = y[3] & w;        // Y4 will be 1 if the next state is D
            end
            y[4]: begin // State D
                Y2 = 1'b0;            // Y2 will remain 0
                Y4 = 1'b0;            // Y4 will remain 0
            end
            y[5]: begin // State E
                Y2 = 1'b0;            // Y2 will remain 0
                Y4 = y[5] & w;        // Y4 will be 1 if the next state is D
            end
            y[6]: begin // State F
                Y2 = 1'b0;            // Y2 will remain 0
                Y4 = y[6] & w;        // Y4 will be 1 if the next state is D
            end
            default: begin // Default case
                Y2 = 1'b0;
                Y4 = 1'b0;
            end
        endcase
    end

endmodule
