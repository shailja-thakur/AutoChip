module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10;  // walking left
        end else begin
            case (state)
                2'b00: begin  // walking right
                    if (bump_left && bump_right) begin
                        state <= 2'b01;  // walking left
                    end else if (bump_right) begin
                        state <= 2'b01;  // walking left
                    end else if (ground) begin
                        state <= 2'b00;  // walking right
                    end
                end
                2'b01: begin  // walking left
                    if (bump_left && bump_right) begin
                        state <= 2'b00;  // walking right
                    end else if (bump_left) begin
                        state <= 2'b00;  // walking right
                    end else if (ground) begin
                        state <= 2'b01;  // walking left
                    end
                end
                default: begin
                    state <= 2'b10;  // walking left
                end
            endcase
        end
    end
    
    assign walk_left = (state == 2'b01);
    assign walk_right = (state == 2'b00);
    assign aaah = (ground == 0) && (!bump_left || !bump_right);
    
endmodule
