module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// State transition logic
always @(*)
begin
    case(y)
        6'b000001: // State A
        begin
            if(w)
            begin
                Y2 = 1'b1;
                Y4 = 1'b0;
            end
            else
            begin
                Y2 = 1'b0;
                Y4 = 1'b0;
            end
        end
        
        6'b000010: // State B
        begin
            if(w)
            begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
            else
            begin
                Y2 = 1'b1;
                Y4 = 1'b1;
            end
        end
        
        6'b000100: // State C
        begin
            if(w)
            begin
                Y2 = 1'b1;
                Y4 = 1'b1;
            end
            else
            begin
                Y2 = 1'b0;
                Y4 = 1'b0;
            end
        end
        
        6'b001000: // State D
        begin
            if(w)
            begin
                Y2 = 1'b1;
                Y4 = 1'b0;
            end
            else
            begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
        end
        
        6'b010000: // State E
        begin
            if(w)
            begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
            else
            begin
                Y2 = 1'b1;
                Y4 = 1'b0;
            end
        end
        
        6'b100000: // State F
        begin
            if(w)
            begin
                Y2 = 1'b1;
                Y4 = 1'b0;
            end
            else
            begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
        end
        
        default: // Invalid state
        begin
            Y2 = 1'b0;
            Y4 = 1'b0;
        end
    endcase
end

endmodule
