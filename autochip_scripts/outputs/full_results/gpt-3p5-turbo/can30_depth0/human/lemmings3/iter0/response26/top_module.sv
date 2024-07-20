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
    reg [1:0] state;
    reg [1:0] next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10;
        end else begin
            state <= next_state;
        end
    end
    
    always @* begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case (state)
            2'b00: begin
                if (bump_left || (bump_left && bump_right)) begin
                    next_state = 2'b01;
                end else if (dig && ground) begin
                    aaah = 0;
                    digging = 1;
                    next_state = 2'b10;
                end else begin
                    aaah = 1;
                    digging = 0;
                    next_state = 2'b10;
                end
            end
            
            2'b01: begin
                if (bump_right || (bump_left && bump_right)) begin
                    next_state = 2'b00;
                end else if (dig && ground) begin
                    aaah = 0;
                    digging = 1;
                    next_state = 2'b11;
                end else begin
                    aaah = 1;
                    digging = 0;
                    next_state = 2'b11;
                end
            end
            
            2'b10: begin
                if (!ground) begin
                    aaah = 1;
                    digging = 0;
                    next_state = 2'b10;
                end else if (dig && ground) begin
                    aaah = 0;
                    digging = 1;
                    next_state = 2'b10;
                end else if (bump_left && bump_right) begin
                    next_state = 2'b11;
                end else if (bump_right) begin
                    next_state = 2'b01;
                end else begin
                    next_state = 2'b00;
                end
            end
            
            2'b11: begin
                if (!ground) begin
                    aaah = 1;
                    digging = 0;
                    next_state = 2'b11;
                end else if (dig && ground) begin
                    aaah = 0;
                    digging = 1;
                    next_state = 2'b11;
                end else if (bump_left && bump_right) begin
                    next_state = 2'b10;
                end else if (bump_left) begin
                    next_state = 2'b00;
                end else begin
                    next_state = 2'b01;
                end
            end
        endcase
    end
endmodule
