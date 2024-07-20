module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

reg Y2, Y4;

always @(*)
begin
	case (y)
		6'b000001: begin
            if (w == 0)
                Y2 = 0;
            else
                Y2 = 0;
            
            if (w == 0)
                Y4 = 0;
            else
                Y4 = 0;
        end
        
		6'b000010: begin
            if (w == 0)
                Y2 = 0;
            else
                Y2 = 1;
            
            if (w == 0)
                Y4 = 0;
            else
                Y4 = 1;
        end
        
		6'b000100: begin
            if (w == 0)
                Y2 = 1;
            else
                Y2 = 0;
            
            if (w == 0)
                Y4 = 0;
            else
                Y4 = 1;
        end
        
		6'b001000: begin
            if (w == 0)
                Y2 = 1;
            else
                Y2 = 0;
            
            if (w == 0)
                Y4 = 1;
            else
                Y4 = 0;
        end
        
		6'b010000: begin
            if (w == 0)
                Y2 = 1;
            else
                Y2 = 1;
            
            if (w == 0)
                Y4 = 1;
            else
                Y4 = 0;
        end
        
		6'b100000: begin
            if (w == 0)
                Y2 = 1;
            else
                Y2 = 0;
            
            if (w == 0)
                Y4 = 1;
            else
                Y4 = 1;
        end
        
		default: begin
			Y2 = 0;
			Y4 = 0;
		end
	endcase
end

endmodule
