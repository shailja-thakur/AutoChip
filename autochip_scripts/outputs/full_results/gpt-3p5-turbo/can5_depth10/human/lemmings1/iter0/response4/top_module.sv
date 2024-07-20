module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg [1:0] state;
    reg walk_left_reg;
    reg walk_right_reg;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10;
        end else begin
            case(state)
                2'b00: begin
                    walk_left_reg <= 1;
                    walk_right_reg <= 0;
                    if (bump_left) begin
                        state <= 2'b01;
                    end
                    if (bump_right) begin
                        state <= 2'b10;
                    end
                end
                2'b01: begin
                    walk_left_reg <= 0;
                    walk_right_reg <= 1;
                    if (bump_right) begin
                        state <= 2'b10;
                    end
                    if (bump_left) begin
                        state <= 2'b01;
                    end
                    if (!bump_left && !bump_right) begin
                        state <= 2'b00;
                    end
                end
                2'b10: begin
                    walk_left_reg <= 1;
                    walk_right_reg <= 0;
                    if (bump_left) begin
                        state <= 2'b01;
                    end
                    if (bump_right) begin
                        state <= 2'b10;
                    end
                    if (!bump_left && !bump_right) begin
                        state <= 2'b00;
                    end
                end
                default: state <= 2'b00;
            endcase
        end
    end
    
    assign walk_left = walk_left_reg;
    assign walk_right = walk_right_reg;

endmodule
