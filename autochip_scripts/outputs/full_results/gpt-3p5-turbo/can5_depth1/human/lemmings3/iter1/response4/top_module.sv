module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left = 1'b0,
    output reg walk_right = 1'b0,
    output reg aaah = 1'b0,
    output reg digging = 1'b0
);

reg [1:0] state;
reg [1:0] next_state;

// States
parameter [1:0] LEFT = 2'b00;
parameter [1:0] RIGHT = 2'b01;
parameter [1:0] FALLING = 2'b10;
parameter [1:0] DIGGING = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end else begin
        state <= next_state;
        walk_left <= 1'b0;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end
end

always @* begin
    case(state)
        LEFT: begin
            if(bump_right) begin
                next_state <= RIGHT;
                walk_left <= 1'b0;
                walk_right <= 1'b1;
            end else if(bump_left) begin
                next_state <= LEFT;
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            end else if(ground == 1'b0) begin
                next_state <= FALLING;
                aaah <= 1'b1;
            end else if(dig && ground == 1'b1) begin
                next_state <= DIGGING;
                digging <= 1'b1;
            end
        end

        RIGHT: begin
            if(bump_left) begin
                next_state <= LEFT;
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            end else if(bump_right) begin
                next_state <= RIGHT;
                walk_left <= 1'b0;
                walk_right <= 1'b1;
            end else if(ground == 1'b0) begin
                next_state <= FALLING;
                aaah <= 1'b1;
            end else if(dig && ground == 1'b1) begin
                next_state <= DIGGING;
                digging <= 1'b1;
            end
        end

        FALLING: begin
            if(ground == 1'b1) begin
                next_state <= LEFT;
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
            end
        end

        DIGGING: begin
            if(ground == 1'b0) begin
                next_state <= FALLING;
                aaah <= 1'b1;
                digging <= 1'b0;
            end else if(dig && ground == 1'b1) begin
                next_state <= DIGGING;
                aaah <= 1'b0;
                digging <= 1'b1;
            end else begin
                next_state <= LEFT;
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
            end
        end
    endcase
end

endmodule
