module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    reg Y2;
    reg Y4;
    
    always @(*)
        case(y)
            7'b0000001: begin // state A
                Y2 = 0;
                Y4 = 0;
            end
            7'b0000010: begin // state B
                Y2 = 0;
                Y4 = 1;
            end
            7'b0000100: begin // state C
                Y2 = 0;
                Y4 = 0;
            end
            7'b0001000: begin // state D
                Y2 = 1;
                Y4 = 1;
            end
            7'b0010000: begin // state E
                Y2 = 1;
                Y4 = 0;
            end
            7'b0100000: begin // state F
                Y2 = 0;
                Y4 = 1;
            end
            default: begin
                Y2 = 0;
                Y4 = 0;
            end
        endcase

endmodule
