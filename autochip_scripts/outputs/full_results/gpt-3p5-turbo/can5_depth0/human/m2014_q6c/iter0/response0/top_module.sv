module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    wire [6:1] y_next;

    assign Y2 = y_next[2];
    assign Y4 = y_next[4];
  
    always @(y or w) begin
        case (y)
            7'b000001:
                if (w == 1'b0)
                    y_next = 7'b000010;
                else
                    y_next = 7'b000001;
            
            7'b000010:
                if (w == 1'b0)
                    y_next = 7'b000100;
                else
                    y_next = 7'b100000;
            
            7'b000100:
                if (w == 1'b0)
                    y_next = 7'b001000;
                else
                    y_next = 7'b010000;
            
            7'b001000:
                if (w == 1'b0)
                    y_next = 7'b010000;
                else
                    y_next = 7'b000001;
            
            7'b010000:
                if (w == 1'b0)
                    y_next = 7'b100000;
                else
                    y_next = 7'b001000;
            
            7'b100000:
                if (w == 1'b0)
                    y_next = 7'b000100;
                else
                    y_next = 7'b001000;
            
            default:
                y_next = 7'b000001;
        endcase
    end

endmodule
