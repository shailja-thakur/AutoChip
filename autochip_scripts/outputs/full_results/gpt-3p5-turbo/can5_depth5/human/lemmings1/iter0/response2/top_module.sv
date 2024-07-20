module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

reg [1:0] state;

parameter LEFT = 2'b00;
parameter RIGHT = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= LEFT;
        walk_left <= 1;
        walk_right <= 0;
    end else begin
        case (state)
            LEFT: begin
                if (bump_right) begin
                    state <= RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                end
            end
            RIGHT: begin
                if (bump_left) begin
                    state <= LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                end
            end
        endcase
    end
end

endmodule
