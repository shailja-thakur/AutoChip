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
        state <= 2'b01; // walk left
    end else begin
        case(state)
            2'b00: begin // walking right
                if (bump_left) begin
                    state <= 2'b01; // switch to walk left
                end else if (bump_right) begin
                    state <= 2'b00; // continue walking right
                end
            end
            2'b01: begin // walking left
                if (bump_right) begin
                    state <= 2'b00; // switch to walk right
                end else if (bump_left) begin
                    state <= 2'b01; // continue walking left
                end
            end
        endcase
    end
end

assign walk_left = (state == 2'b01);
assign walk_right = (state == 2'b00);

endmodule
