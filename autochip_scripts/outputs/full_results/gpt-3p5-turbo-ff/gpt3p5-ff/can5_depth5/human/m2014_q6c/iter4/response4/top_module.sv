module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    // Declare intermediate signals
    wire y2_wire;
    wire y4_wire;
    
    always @* begin
        // Logic equations for Y2 and Y4
        case (y)
            7'b0000001: begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
            7'b0000010: begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
            7'b0000100: begin
                Y2 = 1'b1;
                Y4 = 1'b0;
            end
            7'b0001000: begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
            7'b0010000: begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
            7'b0100000: begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
            7'b1000000: begin
                Y2 = 1'b1;
                Y4 = 1'b0;
            end
            default: begin
                Y2 = 1'b0;
                Y4 = 1'b0;
            end
        endcase
    end
    
endmodule
