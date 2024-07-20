module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output aaah,
    output reg digging
);
    reg [3:0] state;
    reg [4:0] counter;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 4'b0001;  // walking left
            counter <= 5'b00000;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            case (state)
                4'b0001:  // walking left
                    if (bump_right) begin
                        state <= 4'b0010;  // walking right
                        walk_left <= 0;
                        walk_right <= 1;
                        aaah <= 0;
                        digging <= 0;
                    end else if (dig && ground) begin
                        state <= 4'b0110;  // digging
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 1;
                    end else if (~ground) begin
                        state <= 4'b0100;  // falling
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end
                4'b0010:  // walking right
                    if (bump_left) begin
                        state <= 4'b0001;  // walking left
                        walk_left <= 1;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end else if (dig && ground) begin
                        state <= 4'b0110;  // digging
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 1;
                    end else if (~ground) begin
                        state <= 4'b0100;  // falling
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end
                4'b0100:  // falling
                    if (ground) begin
                        state <= 4'b0001;  // walking left
                        walk_left <= 1;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end else if (~ground && counter == 5'b11001) begin
                        state <= 4'b1000;  // splatter
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end
                4'b0110:  // digging
                    if (~ground) begin
                        state <= 4'b0100;  // falling
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end
                4'b1000:  // splatter
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
            endcase
        end
    end

    always @(posedge clk) begin
        if (~areset) begin
            counter <= counter + 1;
        end else begin
            counter <= 5'b00000;
        end
    end
endmodule
