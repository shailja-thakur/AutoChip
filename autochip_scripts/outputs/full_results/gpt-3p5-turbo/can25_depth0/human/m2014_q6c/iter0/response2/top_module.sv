module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State assignments
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    always @* begin
        case (y)
            A: begin
                Y2 = 1'b0;
                Y4 = 1'b0;
            end
            B: begin
                Y2 = 1'b0;
                Y4 = 1'b1;           
            end
            C: begin
                Y2 = 1'b1;
                Y4 = 1'b0;
            end
            D: begin
                Y2 = 1'b1;
                Y4 = 1'b1;
            end
            E: begin
                Y2 = 1'b0;
                Y4 = 1'b0;
            end
            F: begin
                Y2 = 1'b1;
                Y4 = 1'b0;
            end
            default: begin
                Y2 = 1'bx;
                Y4 = 1'bx;
            end
        endcase
    end
    
endmodule
