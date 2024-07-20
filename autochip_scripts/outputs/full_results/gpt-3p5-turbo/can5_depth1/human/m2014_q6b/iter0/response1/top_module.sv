module top_module(
    input [3:1] y,
    input w,
    output reg Y2
    );

    always @(y or w) begin
        case(y)
            3'b000: 
                if(w == 1'b0)
                    Y2 <= 1'b0;
                else if(w == 1'b1)
                    Y2 <= 1'b1;
                
            3'b001: 
                if(w == 1'b0)
                    Y2 <= 1'b0;
                else if(w == 1'b1)
                    Y2 <= 1'b1;
                
            3'b010: 
                if(w == 1'b0)
                    Y2 <= 1'b1;
                else if(w == 1'b1)
                    Y2 <= 1'b0;
                
            3'b011: 
                if(w == 1'b0)
                    Y2 <= 1'b1;
                else if(w == 1'b1)
                    Y2 <= 1'b1;
                
            3'b100: 
                if(w == 1'b0)
                    Y2 <= 1'b0;
                else if(w == 1'b1)
                    Y2 <= 1'b0;
                
            3'b101: 
                if(w == 1'b0)
                    Y2 <= 1'b1;
                else if(w == 1'b1)
                    Y2 <= 1'b1;
                
            default:
                Y2 <= 1'b0;
                
        endcase
    end
endmodule
