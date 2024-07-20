module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    always @* begin
        // Logic equations for Y2 and Y4
        case (y[6:1])
            7'b000001: begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
            7'b000010: begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
            7'b000100: begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
            7'b001000: begin
                Y2 = w;
                Y4 = 1'b0;
            end
            7'b010000: begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
            7'b100000: begin
                Y2 = 1'b1;
                Y4 = w;
            end
            default: begin
                Y2 = 1'b0;
                Y4 = 1'b0;
            end
        endcase
    end
    
endmodule
