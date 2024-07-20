module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left = 1'b1,
    output reg walk_right = 1'b0
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
        end else begin
            case (state)
                2'b00: begin
                    if (bump_left) begin
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                        state <= 2'b01;
                    end else if (bump_right) begin
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        state <= 2'b10;
                    end
                end
                2'b01: begin
                    if (!bump_left) begin
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        state <= 2'b00;
                    end else if (bump_right) begin
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                        state <= 2'b10;
                    end
                end
                2'b10: begin
                    if (bump_left) begin
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                        state <= 2'b01;
                    end else if (!bump_right) begin
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        state <= 2'b00;
                    end
                end
                default: begin
                    state <= 2'b10;
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
            endcase
        end
    end

endmodule
