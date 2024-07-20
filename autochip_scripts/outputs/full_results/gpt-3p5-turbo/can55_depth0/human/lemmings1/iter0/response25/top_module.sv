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
        end else begin
            case (state)
                LEFT: begin
                    if (bump_right && !bump_left) begin
                        state <= RIGHT;
                    end else if (!bump_right && bump_left) begin
                        state <= LEFT;
                    end else begin
                        state <= LEFT;
                    end
                end
                
                RIGHT: begin
                    if (bump_right && !bump_left) begin
                        state <= RIGHT;
                    end else if (!bump_right && bump_left) begin
                        state <= LEFT;
                    end else begin
                        state <= RIGHT;
                    end
                end
            endcase
        end
    end
    
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    
endmodule
