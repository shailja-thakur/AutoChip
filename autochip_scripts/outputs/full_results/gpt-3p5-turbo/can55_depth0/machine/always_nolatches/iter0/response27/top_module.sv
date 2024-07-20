module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

always @(*) begin
    case (scancode)
        16'he06b: begin
            left = 1;
        end
        default: begin
            left = 0;
        end
    endcase
    
    case (scancode)
        16'he072: begin
            down = 1;
        end
        default: begin
            down = 0;
        end
    endcase
    
    case (scancode)
        16'he074: begin
            right = 1;
        end
        default: begin
            right = 0;
        end
    endcase
    
    case (scancode)
        16'he075: begin
            up = 1;
        end
        default: begin
            up = 0;
        end
    endcase
end

endmodule
