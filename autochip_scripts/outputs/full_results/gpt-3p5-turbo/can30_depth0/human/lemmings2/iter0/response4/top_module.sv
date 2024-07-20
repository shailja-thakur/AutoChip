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

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10; // initial state, walking left
        end else begin
            case (state)
                2'b00: begin // state 0, falling
                    aaah <= 1;
                    if (ground) begin
                        if (bump_left && bump_right) begin
                            state <= 2'b11;
                        end else if (bump_left) begin
                            state <= 2'b01;
                        end else if (bump_right) begin
                            state <= 2'b10;
                        end else begin
                            state <= 2'b10;
                        end
                    end
                end
                2'b01: begin // state 1, walking right
                    aaah <= 0;
                    if (ground) begin
                        if (bump_left && bump_right) begin
                            state <= 2'b11;
                        end else if (bump_right) begin
                            state <= 2'b00;
                        end else begin
                            state <= 2'b01;
                        end
                    end
                end
                2'b10: begin // state 2, walking left
                    aaah <= 0;
                    if (ground) begin
                        if (bump_left && bump_right) begin
                            state <= 2'b11;
                        end else if (bump_left) begin
                            state <= 2'b00;
                        end else begin
                            state <= 2'b10;
                        end
                    end
                end
                2'b11: begin // state 3, switching direction
                    aaah <= 0;
                    if (ground) begin
                        if (state == 2'b01) begin
                            state <= 2'b10;
                        end else begin
                            state <= 2'b01;
                        end
                    end
                end
            endcase
        end
    end

    assign walk_left = (state == 2'b10);
    assign walk_right = (state == 2'b01);

endmodule
