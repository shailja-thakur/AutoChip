module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);
 
always @ (y or w) begin
    if (w) begin
        case (y)
            7'b0000001: begin
                Y2 <= 1'b1;
                Y4 <= 1'b1;
            end
 
            7'b0000010: begin
                Y2 <= 1'b0;
                Y4 <= 1'b1;
            end
 
            7'b0000100: begin
                Y2 <= 1'b1;
                Y4 <= 1'b0;
            end
 
            7'b0001000: begin
                Y2 <= 1'b0;
                Y4 <= 1'b0;
            end
 
            7'b0010000: begin
                Y2 <= 1'b1;
                Y4 <= 1'b0;
            end
 
            7'b0100000: begin
                Y2 <= 1'b0;
                Y4 <= 1'b0;
            end
 
            7'b1000000: begin
                Y2 <= 1'b1;
                Y4 <= 1'b1;
            end
 
            default: begin
                Y2 <= 1'b0;
                Y4 <= 1'b0;
            end
        endcase
    end else begin
        Y2 <= 1'b0;
        Y4 <= 1'b0;
    end
end
 
endmodule
