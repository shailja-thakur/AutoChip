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
reg walk_left_reg;
reg walk_right_reg;
reg aaah_reg;
reg digging_reg;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01;
        walk_left_reg <= 1'b1;
        walk_right_reg <= 1'b0;
        aaah_reg <= 1'b0;
        digging_reg <= 1'b0;
    end else begin
        case(state)
            2'b00: begin // Walking Left
                if (bump_right == 1'b1) begin
                    state <= 2'b01;
                    walk_left_reg <= 1'b0;
                    walk_right_reg <= 1'b1;
                    aaah_reg <= 1'b0;
                    digging_reg <= 1'b0;
                end else if (ground == 1'b0) begin
                    state <= 2'b10;
                    walk_left_reg <= 1'b0;
                    walk_right_reg <= 1'b0;
                    aaah_reg <= 1'b1;
                    digging_reg <= 1'b0;
                end else if (dig == 1'b1 && ground == 1'b1) begin
                    state <= 2'b11;
                    walk_left_reg <= 1'b0;
                    walk_right_reg <= 1'b0;
                    aaah_reg <= 1'b0;
                    digging_reg <= 1'b1;
                end else begin
                    state <= 2'b00;
                    walk_left_reg <= 1'b1;
                    walk_right_reg <= 1'b0;
                    aaah_reg <= 1'b0;
                    digging_reg <= 1'b0;
                end
            end
            2'b01: begin // Walking Right
                if (bump_left == 1'b1) begin
                    state <= 2'b00;
                    walk_left_reg <= 1'b1;
                    walk_right_reg <= 1'b0;
                    aaah_reg <= 1'b0;
                    digging_reg <= 1'b0;
                end else if (ground == 1'b0) begin
                    state <= 2'b10;
                    walk_left_reg <= 1'b0;
                    walk_right_reg <= 1'b0;
                    aaah_reg <= 1'b1;
                    digging_reg <= 1'b0;
                end else if (dig == 1'b1 && ground == 1'b1) begin
                    state <= 2'b11;
                    walk_left_reg <= 1'b0;
                    walk_right_reg <= 1'b0;
                    aaah_reg <= 1'b0;
                    digging_reg <= 1'b1;
                end else begin
                    state <= 2'b01;
                    walk_left_reg <= 1'b0;
                    walk_right_reg <= 1'b1;
                    aaah_reg <= 1'b0;
                    digging_reg <= 1'b0;
                end
            end
            2'b10: begin // Falling
                if (ground == 1'b1) begin
                    state <= 2'b00;
                    walk_left_reg <= walk_left_reg;
                    walk_right_reg <= walk_right_reg;
                    aaah_reg <= 1'b0;
                    digging_reg <= digging_reg;
                end else begin
                    state <= 2'b10;
                    walk_left_reg <= walk_left_reg;
                    walk_right_reg <= walk_right_reg;
                    aaah_reg <= 1'b1;
                    digging_reg <= digging_reg;
                end
            end
            2'b11: begin // Digging
                if (ground == 1'b0) begin
                    state <= 2'b10;
                    walk_left_reg <= walk_left_reg;
                    walk_right_reg <= walk_right_reg;
                    aaah_reg <= 1'b1;
                    digging_reg <= 1'b0;
                end else begin
                    state <= 2'b11;
                    walk_left_reg <= walk_left_reg;
                    walk_right_reg <= walk_right_reg;
                    aaah_reg <= 1'b0;
                    digging_reg <= 1'b1;
                end
            end
        endcase
    end
end

assign walk_left = walk_left_reg;
assign walk_right = walk_right_reg;
assign aaah = aaah_reg;
assign digging = digging_reg;

endmodule
