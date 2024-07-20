module top_module(
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

reg [1:0] state;

// Moore state machine states
localparam LEFT = 2'b00;
localparam RIGHT = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= LEFT; // reset to walk left
        walk_left <= 1'b1;
        walk_right <= 1'b0;
    end else begin
        case (state)
            LEFT: begin
                if (bump_left) begin
                    state <= RIGHT; // switch to walk right
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end
            end
            
            RIGHT: begin
                if (bump_right) begin
                    state <= LEFT; // switch to walk left
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
