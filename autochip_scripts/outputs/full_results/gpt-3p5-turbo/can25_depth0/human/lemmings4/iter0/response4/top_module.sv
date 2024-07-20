module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);
    
    reg [4:0] state;
    reg [4:0] nextState;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 5'b00000;
        end else begin
            state <= nextState;
        end
    end
    
    always @(*) begin
        nextState = state;
        
        case (state)
            5'b00000: begin // Walking Left
                if (bump_left) begin
                    nextState = 5'b00001; // Walking Right
                end else if (bump_right) begin
                    nextState = 5'b00010; // Walking Left
                end else if (dig) begin
                    nextState = 5'b00100; // Digging
                end else if (ground == 0) begin
                    nextState = 5'b01000; // Falling
                end
            end
            
            5'b00001: begin // Walking Right
                if (bump_right) begin
                    nextState = 5'b00000; // Walking Left
                end else if (bump_left) begin
                    nextState = 5'b00010; // Walking Right
                end else if (dig) begin
                    nextState = 5'b00100; // Digging
                end else if (ground == 0) begin
                    nextState = 5'b01000; // Falling
                end
            end
            
            5'b00010: begin // Bumped Left, Switching to Walking Right
                nextState = 5'b00001; // Walking Right
            end
            
            5'b00100: begin // Digging
                if (~dig) begin
                    nextState = 5'b00000; // Walking Left
                end else if (ground == 0) begin
                    nextState = 5'b01000; // Falling
                end
            end
            
            5'b01000: begin // Falling
                if (ground) begin
                    nextState = 5'b01001; // Walking Left After Falling
                end
            end
            
            5'b01001: begin // Walking Left After Falling
                if (bump_left) begin
                    nextState = 5'b01010; // Walking Right After Falling
                end else if (bump_right) begin
                    nextState = 5'b01000; // Falling
                end else if (dig) begin
                    nextState = 5'b00100; // Digging
                end
            end
            
            5'b01010: begin // Walking Right After Falling
                if (bump_right) begin
                    nextState = 5'b01001; // Walking Left After Falling
                end else if (bump_left) begin
                    nextState = 5'b01000; // Falling
                end else if (dig) begin
                    nextState = 5'b00100; // Digging
                end
            end
        endcase
    end
    
    always @(*) begin
        walk_left = (state == 5'b00000 || state == 5'b00100 || state == 5'b01001);
        walk_right = (state == 5'b00001 || state == 5'b01010);
        aaah = (state == 5'b01000);
        digging = (state == 5'b00100);
    end
    
endmodule
