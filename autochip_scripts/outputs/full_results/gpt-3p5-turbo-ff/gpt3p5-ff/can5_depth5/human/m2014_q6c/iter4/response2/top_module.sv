module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    always @* begin
        case(y)
            // State A
            7'b0000001, 7'b0100000: begin
                Y2 = 1'b0;
                Y4 = 1'b0;
            end
            // State B
            7'b0000010: begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
            // State C
            7'b0000100: begin
                Y2 = 1'b1;
                Y4 = 1'b0;
            end
            // State D
            7'b0001000, 7'b0100000: begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
            // State E
            7'b0010000: begin
                Y2 = 1'b1;
                Y4 = 1'b1;
            end
            // State F
            7'b0100000: begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
            default: begin
                Y2 = 1'b0;
                Y4 = 1'b0;
            end
        endcase
    end
    
endmodule
