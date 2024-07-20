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
    
    initial begin
        state <= 2'b00; // walking left
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;
        end
        else begin
            state <= next_state;
        end
    end
    
    always @(state or bump_left or bump_right or ground or dig) begin
        case(state)
            2'b00: begin // walking left
                if (bump_right) begin
                    next_state = 2'b01; // walking right
                    walk_right <= 1;
                    aaah <= 0;
                end
                else if (ground == 0) begin
                    next_state = 2'b10; // falling
                    aaah <= 1;
                end
                else if (dig) begin
                    next_state = 2'b11; // digging
                    digging <= 1;
                end
            end
            2'b01: begin // walking right
                if (bump_left) begin
                    next_state = 2'b00; // walking left
                    walk_left <= 1;
                    aaah <= 0;
                end
                else if (ground == 0) begin
                    next_state = 2'b10; // falling
                    aaah <= 1;
                end
                else if (dig) begin
                    next_state = 2'b11; // digging
                    digging <= 1;
                end
            end
            2'b10: begin // falling
                next_state = (ground) ? state : (bump_right || bump_left) ? 2'b11 : (dig) ? 2'b11 : 2'b10;
                walk_left <= (ground && state == 2'b00) ? 1 : 0;
                walk_right <= (ground && state == 2'b01) ? 1 : 0;
                aaah <= 1;
                digging <= 0;
            end
            2'b11: begin // digging
                next_state = (ground) ? ((state == 2'b00) ? 2'b00 : 2'b01) : (bump_right || bump_left) ? 2'b10 : (dig) ? 2'b11 : 2'b10;
                walk_left <= (ground && state == 2'b00) ? 1 : 0;
                walk_right <= (ground && state == 2'b01) ? 1 : 0;
                aaah <= 0;
                digging <= 1;
            end
        endcase
    end
    
    assign walk_left = (state == 2'b00);
    assign walk_right = (state == 2'b01);
    
endmodule
