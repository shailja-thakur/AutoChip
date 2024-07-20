module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    reg [1:0] state; // state variable to hold the current state
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= 2'b10; // reset the state to walk left
        end else begin
            case (state)
                2'b10: begin // walking left state
                    if (bump_left) begin
                        state <= 2'b01; // switch to walking right state
                    end else if (bump_right) begin
                        state <= 2'b10; // continue walking left
                    end
                end
                2'b01: begin // walking right state
                    if (bump_right) begin
                        state <= 2'b10; // switch to walking left state
                    end else if (bump_left) begin
                        state <= 2'b01; // continue walking right
                    end
                end
                default: state <= 2'b10; // default to walking left state
            endcase
        end
    end
    
    assign walk_left = (state == 2'b10);
    assign walk_right = (state == 2'b01);
    
endmodule
