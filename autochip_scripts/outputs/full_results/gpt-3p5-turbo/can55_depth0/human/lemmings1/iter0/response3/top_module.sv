module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10; // walk_left
        end else begin
            case (state)
                2'b10: begin // walk_left
                    if (bump_right == 1'b1 && bump_left == 1'b0) begin
                        state <= 2'b01; // walk_right
                    end
                end
                2'b01: begin // walk_right
                    if (bump_left == 1'b1 && bump_right == 1'b0) begin
                        state <= 2'b10; // walk_left
                    end
                end
                default: begin
                    state <= 2'b10; // walk_left
                end
            endcase
        end
    end
    
    assign walk_left = (state == 2'b10) ? 1'b1 : 1'b0;
    assign walk_right = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
