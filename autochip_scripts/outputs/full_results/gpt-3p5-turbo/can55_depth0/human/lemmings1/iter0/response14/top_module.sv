module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    reg state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 1'b1;  // walking left state
            walk_left <= 1'b1;
            walk_right <= 1'b0;
        end else begin
            case (state)
                1'b1: begin  // walking left state
                    if (bump_left) begin
                        state <= 1'b0;  // walking right state
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                    end
                end
                1'b0: begin  // walking right state
                    if (bump_right) begin
                        state <= 1'b1;  // walking left state
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                    end
                end
            endcase
        end
    end
    
endmodule
