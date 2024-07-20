module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    
    reg [1:0] state;
    wire walk_left, walk_right;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10; // walking left state
        end else begin
            case(state)
                2'b10: begin // walking left state
                    if (bump_right || (bump_left && bump_right)) begin // check if bumped on the right or bumped on both sides
                        state <= 2'b01; // switch to walking right state
                    end
                end
                2'b01: begin // walking right state
                    if (bump_left || (bump_left && bump_right)) begin // check if bumped on the left or bumped on both sides
                        state <= 2'b10; // switch to walking left state
                    end
                end
            endcase
        end
    end
    
    assign walk_left = (state == 2'b10); // output walk_left when in walking left state
    assign walk_right = (state == 2'b01); // output walk_right when in walking right state
    
endmodule
