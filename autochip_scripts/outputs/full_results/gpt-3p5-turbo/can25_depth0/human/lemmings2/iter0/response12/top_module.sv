module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    reg [1:0] state;
    parameter idle = 2'b00;
    parameter left = 2'b01;
    parameter right = 2'b10;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= idle;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
        end else begin
            case(state)
                idle: begin
                    if (bump_left && bump_right) begin
                        state <= idle;
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                    end else if (bump_left) begin
                        state <= right;
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                        aaah <= 1'b0;
                    end else if (bump_right) begin
                        state <= left;
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                    end else if (ground == 0) begin
                        state <= idle;
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        aaah <= 1'b1;
                    end
                end
                left: begin
                    if (ground == 1) begin
                        state <= left;
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                    end else begin
                        state <= left;
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        aaah <= 1'b1;
                    end
                end
                right: begin
                    if (ground == 1) begin
                        state <= right;
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                        aaah <= 1'b0;
                    end else begin
                        state <= right;
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        aaah <= 1'b1;
                    end
                end
            endcase
        end
    end
endmodule
