module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg [1:0] state;
    
    assign walk_left = (state == 2'b00);
    assign walk_right = (state == 2'b01);
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;
        end else begin
            case (state)
                2'b00: begin
                    if (bump_left) begin
                        state <= 2'b01;
                    end else if (bump_right) begin
                        state <= 2'b10;
                    end
                end
                2'b01: begin
                    if (bump_right) begin
                        state <= 2'b10;
                    end else if (bump_left) begin
                        state <= 2'b00;
                    end
                end
                2'b10: begin
                    if (bump_left || bump_right) begin
                        state <= 2'b01;
                    end
                end
                default: state <= 0;
            endcase
        end
    end
endmodule
