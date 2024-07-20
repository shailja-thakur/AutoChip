module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg [1:0] state;
    reg walk_left;
    reg walk_right;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Initialize state to walking left
            walk_left <= 1;
            walk_right <= 0;
        end else begin
            case (state)
                2'b00: begin // Walking left state
                    if (bump_right) begin
                        state <= 2'b01; // Switch direction to walking right
                        walk_left <= 0;
                        walk_right <= 1;
                    end else if (bump_left || (bump_left && bump_right)) begin
                        state <= 2'b00; // Continue walking left
                        walk_left <= 1;
                        walk_right <= 0;
                    end
                end
                2'b01: begin // Walking right state
                    if (bump_left) begin
                        state <= 2'b00; // Switch direction to walking left
                        walk_left <= 1;
                        walk_right <= 0;
                    end else if (bump_right || (bump_left && bump_right)) begin
                        state <= 2'b01; // Continue walking right
                        walk_left <= 0;
                        walk_right <= 1;
                    end
                end
            endcase
        end
    end
  
endmodule
