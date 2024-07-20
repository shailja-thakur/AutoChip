module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

    always @(*) begin
        case (scancode)
            16'hE06B: begin
                left = 1;
                down = 0;
                right = 0;
                up = 0;
            end
            16'hE072: begin
                left = 0;
                down = 1;
                right = 0;
                up = 0;
            end
            16'hE074: begin
                left = 0;
                down = 0;
                right = 1;
                up = 0;
            end
            16'hE075: begin
                left = 0;
                down = 0;
                right = 0;
                up = 1;
            end
            default: begin
                left = 0;
                down = 0;
                right = 0;
                up = 0;
            end
        endcase
    end

endmodule
