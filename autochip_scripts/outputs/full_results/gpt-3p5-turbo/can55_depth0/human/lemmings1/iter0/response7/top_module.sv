module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg [1:0] state;
    wire switch_direction;
    
    assign walk_left = (state == 2'b01);
    assign walk_right = (state == 2'b10);
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;
        end else begin
            if (switch_direction) begin
                state <= ~state;
            end else begin
                state <= state;
            end
        end
    end
    
    assign switch_direction = bump_left | bump_right;
    
endmodule
