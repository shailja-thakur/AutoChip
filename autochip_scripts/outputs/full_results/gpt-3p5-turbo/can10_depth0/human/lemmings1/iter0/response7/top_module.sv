module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b10; // walking left state
        walk_left <= 1;
        walk_right <= 0;
    end else begin
        case(state)
            2'b10: begin // walking left state
                if (bump_right) begin
                    state <= 2'b01; // walking right state
                    walk_left <= 0;
                    walk_right <= 1;
                end else begin
                    walk_left <= 1;
                    walk_right <= 0;
                end
            end
            2'b01: begin // walking right state
                if (bump_left) begin
                    state <= 2'b10; // walking left state
                    walk_left <= 1;
                    walk_right <= 0;
                end else begin
                    walk_left <= 0;
                    walk_right <= 1;
                end
            end
            default: begin // idle state
                walk_left <= 0;
                walk_right <= 0;
            end
        endcase
    end
end

endmodule
