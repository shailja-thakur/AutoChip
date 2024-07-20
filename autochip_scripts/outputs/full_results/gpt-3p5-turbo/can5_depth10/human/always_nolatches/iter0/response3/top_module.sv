module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

    always @(*) begin
        case(scancode)
            16'hE06B: begin // left arrow
                left = 1'b1;
                down = 1'b0;
                right = 1'b0;
                up = 1'b0;
            end
            16'hE072: begin // down arrow
                left = 1'b0;
                down = 1'b1;
                right = 1'b0;
                up = 1'b0;
            end
            16'hE074: begin // right arrow
                left = 1'b0;
                down = 1'b0;
                right = 1'b1;
                up = 1'b0;
            end
            16'hE075: begin // up arrow
                left = 1'b0;
                down = 1'b0;
                right = 1'b0;
                up = 1'b1;
            end
            default: begin // none
                left = 1'b0;
                down = 1'b0;
                right = 1'b0;
                up = 1'b0;
            end
        endcase
    end

endmodule
