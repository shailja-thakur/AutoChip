module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);

    reg [4:0] state;
    reg [4:0] next_state;
    reg walk_left;
    reg walk_right;
    reg aaah;
    reg digging;
    reg splatter;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 5'b00001;
        else
            state <= next_state;
    end

    always @(*) begin
        walk_left = (state == 5'b00001 || state == 5'b00010 || state == 5'b10000);
        walk_right = (state == 5'b00001 || state == 5'b00010 || state == 5'b10000);
        aaah = (state == 5'b01001 || (state == 5'b11001 && ground));
        digging = (state == 5'b10000 || (state == 5'b01000 && ground));
        splatter = (state == 5'b01011 && ground);
    end

    always @(*) begin
        next_state = state;
        case (state)
            5'b00001: begin
                if (bump_left && bump_right)
                    next_state = 5'b00001;
                else if (bump_left)
                    next_state = 5'b00010;
                else if (bump_right)
                    next_state = 5'b00001;
                else if (!ground)
                    next_state = 5'b01001;
                else if (dig && ground)
                    next_state = 5'b10000;
            end
            5'b00010: begin
                if (bump_right)
                    next_state = 5'b00001;
                else if (!ground)
                    next_state = 5'b01001;
                else if (dig && ground)
                    next_state = 5'b10000;
            end
            5'b01001: begin
                if (ground)
                    next_state = 5'b00001;
            end
            5'b10000: begin
                if (!ground)
                    next_state = 5'b01000;
            end
            5'b01000: begin
                if (!ground)
                    next_state = 5'b01011;
            end
            5'b01011: begin
                if (ground)
                    next_state = 5'b00001;
            end
        endcase
    end

endmodule
