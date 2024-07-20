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
    reg [4:0] next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 5'b00000;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            5'b00000: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
                if (bump_left) begin
                    next_state = 5'b00010;
                end else if (bump_right) begin
                    next_state = 5'b00001;
                end else if (!ground) begin
                    next_state = 5'b10000;
                end else if (dig) begin
                    next_state = 5'b00100;
                end else begin
                    next_state = 5'b00000;
                end
            end

            5'b00001: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
                if (bump_left) begin
                    next_state = 5'b00010;
                end else if (!ground) begin
                    next_state = 5'b10000;
                end else if (dig) begin
                    next_state = 5'b00100;
                end else begin
                    next_state = 5'b00000;
                end
            end

            5'b00010: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b0;
                digging = 1'b0;
                if (bump_right) begin
                    next_state = 5'b00001;
                end else if (!ground) begin
                    next_state = 5'b10000;
                end else if (dig) begin
                    next_state = 5'b00100;
                end else begin
                    next_state = 5'b00000;
                end
            end

            5'b00100: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b1;
                if (!ground) begin
                    next_state = 5'b10000;
                end else begin
                    next_state = 5'b00100;
                end
            end

            5'b10000: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b1;
                digging = 1'b0;
                if (ground) begin
                    next_state = 5'b00001;
                end else begin
                    next_state = 5'b10000;
                end
            end

            default: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
                next_state = 5'b00000;
            end
        endcase
    end
endmodule
