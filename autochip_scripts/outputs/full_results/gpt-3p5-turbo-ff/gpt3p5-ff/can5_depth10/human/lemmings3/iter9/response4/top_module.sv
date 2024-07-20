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
    reg falling;
    reg [1:0] next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to walk left state
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
            falling <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        case (state)
            2'b00: begin // Fall state
                next_state = ground ? (walk_left ? 2'b01 : 2'b10) : state;
                walk_left = walk_left;
                walk_right = walk_right;
                aaah = 1;
                digging = 0;
            end
            
            2'b01: begin // Walk left state
                next_state = bump_right ? 2'b10 : (dig ? 2'b11 : (ground ? state : 2'b00));
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
            
            2'b10: begin // Walk right state
                next_state = bump_left ? 2'b01 : (dig ? 2'b11 : (ground ? state : 2'b00));
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
            end
            
            2'b11: begin // Dig state
                next_state = ground ? (dig ? state : 2'b00) : state;
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
            end
        endcase
    end
endmodule
