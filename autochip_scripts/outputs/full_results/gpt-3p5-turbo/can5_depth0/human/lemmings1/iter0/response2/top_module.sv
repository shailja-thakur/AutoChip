module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    reg [1:0] curr_state;
    
    parameter LEFT = 2'b0;
    parameter RIGHT = 2'b1;
    
    // Reset state of the machine
    always @(posedge areset)
        curr_state <= LEFT;
        
    // State transition logic
    always @(posedge clk) begin
        if (curr_state == LEFT) begin
            if (bump_right) begin
                curr_state <= RIGHT;
            end
        end
        else begin // curr_state == RIGHT
            if (bump_left) begin
                curr_state <= LEFT;
            end
        end
    end

    // Output logic
    always @(curr_state) begin
        if (curr_state == LEFT) begin
            walk_left <= 1;
            walk_right <= 0;
        end
        else begin // curr_state == RIGHT
            walk_left <= 0;
            walk_right <= 1;
        end
    end
    
endmodule
