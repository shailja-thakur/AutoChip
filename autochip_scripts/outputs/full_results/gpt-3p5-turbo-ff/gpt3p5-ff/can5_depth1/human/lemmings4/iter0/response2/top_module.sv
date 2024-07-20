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
    reg walk_left_reg;
    reg walk_right_reg;
    reg aaah_reg;
    reg dig_reg;

    always @(posedge clk or areset) begin
        if (areset) begin
            state <= 5'b00000;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        walk_left_reg = state == 5'b00001;
        walk_right_reg = state == 5'b00010;
        aaah_reg = state == 5'b00101;
        dig_reg = state == 5'b01001;
    end

    always @(*) begin
        case(state)
            5'b00000: begin // Walking left
                if (bump_right) begin
                    next_state = 5'b00010;
                end else if (~ground) begin
                    next_state = 5'b00101;
                end else if (dig) begin
                    next_state = 5'b01001;
                end else begin
                    next_state = 5'b00000;
                end
            end

            5'b00001: begin // Walking left
                if (bump_right) begin
                    next_state = 5'b00010;
                end else if (~ground) begin
                    next_state = 5'b00101;
                end else if (dig) begin
                    next_state = 5'b01001;
                end else begin
                    next_state = 5'b00001;
                end
            end

            5'b00010: begin // Walking right
                if (bump_left) begin
                    next_state = 5'b00001;
                end else if (~ground) begin
                    next_state = 5'b00101;
                end else if (dig) begin
                    next_state = 5'b01001;
                end else begin
                    next_state = 5'b00010;
                end
            end

            5'b00101: begin // Falling "aaah!"
                if (ground) begin
                    next_state = 5'b00000;
                end else if ((state == 5'b00101) && (bump_left || bump_right)) begin
                    next_state = 5'b00101;
                end else if (state == 5'b00101) begin
                    next_state = 5'b00101;
                end
            end

            5'b01001: begin // Digging
                if (ground) begin
                    next_state = 5'b00000;
                end else if (~ground) begin
                    next_state = 5'b00101;
                end else if ((state == 5'b01001) && (bump_left || bump_right)) begin
                    next_state = 5'b01001;
                end
            end
        endcase
    end

    assign walk_left = walk_left_reg;
    assign walk_right = walk_right_reg;
    assign aaah = aaah_reg;
    assign digging = dig_reg;

endmodule
