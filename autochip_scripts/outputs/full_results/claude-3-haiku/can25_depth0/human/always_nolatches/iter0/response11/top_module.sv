module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

always @(*) begin
    // Initialize all outputs to 0
    left = 0;
    down = 0;
    right = 0;
    up = 0;
    
    case (scancode)
        16'he06b: begin
            left = 1;
        end
        16'he072: begin
            down = 1;
        end
        16'he074: begin
            right = 1;
        end
        16'he075: begin
            up = 1;
        end
        default: begin
            // Do nothing
        end
    endcase
end

endmodule
