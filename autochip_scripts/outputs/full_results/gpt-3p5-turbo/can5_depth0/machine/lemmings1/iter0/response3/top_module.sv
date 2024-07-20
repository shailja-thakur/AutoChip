module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);
	
    parameter WL = 0;
    parameter WR = 1;
    
    reg state;
    wire next_state;
    
    always @(posedge clk or posedge areset) begin
        if(areset)
            state <= WL;
        else
            state <= next_state;
    end
    
    assign next_state = (state == WL && bump_left) ? WR :
                       (state == WR && bump_right) ? WL :
                       state;
    
    always @(posedge clk) begin
        if(state == WL) begin
            walk_left <= 1;
            walk_right <= 0;
        end else begin
            walk_left <= 0;
            walk_right <= 1;
        end
    end
    
endmodule
