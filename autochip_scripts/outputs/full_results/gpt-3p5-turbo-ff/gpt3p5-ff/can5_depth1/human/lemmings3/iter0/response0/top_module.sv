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
    reg [1:0] state;
    reg walk_left, walk_right, aaah, digging;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // walking left
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end
        else begin
            case(state)
                2'b00: begin // walking left
                    if (bump_right)
                        state <= 2'b01; // walking right
                    else if (dig && ground) begin
                        state <= 2'b10; // digging
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 1;
                    end
                    else if (!ground)
                        state <= 2'b11; // falling
                end
                2'b01: begin // walking right
                    if (bump_left)
                        state <= 2'b00; // walking left
                    else if (dig && ground) begin
                        state <= 2'b10; // digging
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 1;
                    end
                    else if (!ground)
                        state <= 2'b11; // falling
                end
                2'b10: begin // digging
                    if (!ground) begin
                        state <= 2'b11; // falling
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end
                end
                2'b11: begin // falling
                    if (ground) begin
                        if (state == 2'b00)
                            state <= 2'b00; // walking left
                        else
                            state <= 2'b01; // walking right
                        walk_left <= (state == 2'b00) ? 1 : 0;
                        walk_right <= (state == 2'b01) ? 1 : 0;
                        aaah <= 0;
                        digging <= 0;
                    end
                end
            endcase
        end
    end
endmodule
