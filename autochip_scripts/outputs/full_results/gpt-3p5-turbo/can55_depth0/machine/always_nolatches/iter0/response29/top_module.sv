module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

    always @(*) begin
        // Check scancode value and set corresponding outputs accordingly
        if (scancode == 16'hE06B) begin
            left = 1;
        end else begin
            left = 0;
        end
        
        if (scancode == 16'hE072) begin
            down = 1;
        end else begin
            down = 0;
        end
        
        if (scancode == 16'hE074) begin
            right = 1;
        end else begin
            right = 0;
        end
        
        if (scancode == 16'hE075) begin
            up = 1;
        end else begin
            up = 0;
        end
    end
    
endmodule
