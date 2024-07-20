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
        state <= 2'b01; // Initial state: walk_left
    end else begin
        case (state)
            2'b01: begin // walk_left state
                if (bump_right) begin
                    state <= 2'b10; // Switch to walk_right state
                end
            end
            2'b10: begin // walk_right state
                if (bump_left) begin
                    state <= 2'b01; // Switch to walk_left state
                end
            end
        endcase
    end
end

always @(state) begin
    case (state)
        2'b01: begin // walk_left state
            walk_left = 1;
            walk_right = 0;
        end
        2'b10: begin // walk_right state
            walk_left = 0;
            walk_right = 1;
        end
    endcase
end

endmodule
