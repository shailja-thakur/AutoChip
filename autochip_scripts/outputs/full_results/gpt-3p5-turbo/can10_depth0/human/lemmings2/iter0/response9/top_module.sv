module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

    reg [1:0] state;
    reg current_direction;
    reg next_direction;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;
            current_direction <= 1'b1;
            next_direction <= 1'b1;
        end else begin
            case (state)
                2'b00: begin // State: Walking Left
                    if (ground) begin
                        aaah <= 1'b0;
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        if (bump_right) begin
                            state <= 2'b01;
                            current_direction <= 1'b1;
                            next_direction <= 1'b1;
                        end
                    end else begin
                        aaah <= 1'b1;
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        state <= 2'b10;
                        current_direction <= 1'b1;
                    end
                end

                2'b01: begin // State: Walking Right
                    if (ground) begin
                        aaah <= 1'b0;
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                        if (bump_left) begin
                            state <= 2'b00;
                            current_direction <= 1'b0;
                            next_direction <= 1'b0;
                        end
                    end else begin
                        aaah <= 1'b1;
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        state <= 2'b10;
                        current_direction <= 1'b0;
                    end
                end

                2'b10: begin // State: Falling
                    if (ground) begin
                        state <= (next_direction == 1'b1) ? 2'b00 : 2'b01;
                        current_direction <= next_direction;
                        next_direction <= current_direction;
                    end else begin
                        aaah <= 1'b1;
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule
