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
    reg walk_left;
    reg walk_right;
    reg aaah;
    reg digging;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10; // walk_left
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            case(state)
                2'b00: begin // walk_right
                    if (bump_left) begin
                        state <= 2'b10; // walk_left
                        walk_left <= 1;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end else if (bump_right || (bump_left && bump_right)) begin
                        state <= 2'b01; // walk_right
                        walk_left <= 0;
                        walk_right <= 1;
                        aaah <= 0;
                        digging <= 0;
                    end else if (dig) begin
                        state <= 2'b00; // walk_right
                        walk_left <= 0;
                        walk_right <= 1;
                        aaah <= 0;
                        digging <= 1;
                    end else if (ground) begin
                        state <= 2'b00; // walk_right
                        walk_left <= 0;
                        walk_right <= 1;
                        aaah <= 0;
                        digging <= 0;
                    end else begin
                        state <= 2'b11; // aaah
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end
                end
                2'b01: begin // walk_left
                    if (bump_right) begin
                        state <= 2'b01; // walk_left
                        walk_left <= 1;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end else if (bump_left || (bump_left && bump_right)) begin
                        state <= 2'b00; // walk_right
                        walk_left <= 0;
                        walk_right <= 1;
                        aaah <= 0;
                        digging <= 0;
                    end else if (dig) begin
                        state <= 2'b01; // walk_left
                        walk_left <= 1;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 1;
                    end else if (ground) begin
                        state <= 2'b01; // walk_left
                        walk_left <= 1;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end else begin
                        state <= 2'b11; // aaah
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end
                end
                2'b10: begin // aaah
                    if (bump_left) begin
                        state <= 2'b01; // walk_right
                        walk_left <= 0;
                        walk_right <= 1;
                        aaah <= 0;
                        digging <= 0;
                    end else if (bump_right) begin
                        state <= 2'b00; // walk_left
                        walk_left <= 1;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end else if (dig) begin
                        state <= 2'b10; // aaah
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 1;
                    end else if (ground) begin
                        state <= 2'b10; // aaah
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end else begin
                        state <= 2'b11; // aaah
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end
                end
                2'b11: begin // digging
                    if (bump_left || bump_right || dig) begin
                        state <= 2'b11; // aaah
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end else if (ground) begin
                        state <= 2'b00; // walk_right
                        walk_left <= 0;
                        walk_right <= 1;
                        aaah <= 0;
                        digging <= 0;
                    end else begin
                        state <= 2'b11; // aaah
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end
                end
            endcase
        end
    end
endmodule
