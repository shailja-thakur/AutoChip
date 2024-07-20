module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

reg Y2;
reg Y4;

always @(*)
begin
    case(y)
        7'b000001:       // A
        begin
            Y2 = 1'b0;
            Y4 = 1'b0;
        end
        
        7'b000010:       // B
        begin
            Y2 = 1'b1;
            Y4 = 1'b0;
        end
        
        7'b000100:       // C
        begin
            Y2 = 1'b0;
            Y4 = 1'b1;
        end
        
        7'b001000:       // D
        begin
            Y2 = 1'b1;
            Y4 = 1'b1;
        end
        
        7'b010000:       // E
        begin
            Y2 = 1'b0;
            Y4 = 1'b0;
        end
        
        7'b100000:       // F
        begin
            Y2 = 1'b0;
            Y4 = 1'b0;
        end
    endcase
end

endmodule
