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
    reg [4:0] count;
    reg walk_dir;
    reg is_falling;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;  // walking left
            count <= 5'b00000;
            walk_dir <= 1'b0;
            is_falling <= 1'b0;
        end else begin
            case (state)
                2'b00: begin  // walking left
                    if ((bump_right || (!ground && !is_falling)) && count < 5'b10100) begin
                        state <= 2'b01;  // walking right
                        walk_dir <= 1'b1;
                        count <= count + 1'b1;
                    end else if (dig && ground) begin
                        state <= 2'b10;  // digging
                        walk_dir <= walk_dir;
                        count <= count + 1'b1;
                    end else begin
                        state <= state;
                        walk_dir <= walk_dir;
                        count <= 5'b00000;
                    end
                    is_falling <= (ground) ? 1'b0 : 1'b1;
                end

                2'b01: begin  // walking right
                    if ((bump_left || (!ground && !is_falling)) && count < 5'b10100) begin
                        state <= 2'b00;  // walking left
                        walk_dir <= 1'b0;
                        count <= count + 1'b1;
                    end else if (dig && ground) begin
                        state <= 2'b10;  // digging
                        walk_dir <= walk_dir;
                        count <= count + 1'b1;
                    end else begin
                        state <= state;
                        walk_dir <= walk_dir;
                        count <= 5'b00000;
                    end
                    is_falling <= (ground) ? 1'b0 : 1'b1;
                end

                2'b10: begin  // digging
                    if (ground && (!dig || !walk_dir)) begin
                        state <= 2'b00;  // walking left
                        walk_dir <= 1'b0;
                        count <= 5'b00000;
                    end else begin
                        state <= state;
                        walk_dir <= walk_dir;
                        count <= 5'b00000;
                    end
                    is_falling <= (ground) ? 1'b0 : 1'b1;
                end
            endcase
        end
    end

    assign walk_left = (state == 2'b00 && !is_falling) ? 1'b1 : 1'b0;
    assign walk_right = (state == 2'b01 && !is_falling) ? 1'b1 : 1'b0;
    assign aaah = (is_falling && count == 5'b10100) ? 1'b1 : 1'b0;
    assign digging = (state == 2'b10) ? 1'b1 : 1'b0;

endmodule
