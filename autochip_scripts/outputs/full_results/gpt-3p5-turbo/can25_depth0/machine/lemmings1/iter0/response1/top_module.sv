module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    // Define states
    parameter WL = 0;
    parameter WR = 1;
    
    // Define state register
    reg state;
    
    // Combinational logic for next state and output assignment
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WL;
        end else begin
            if (state == WL) begin
                if (bump_left) begin
                    state <= WR;
                end else begin
                    state <= WL;
                end
            end else if (state == WR) begin
                if (bump_right) begin
                    state <= WL;
                end else begin
                    state <= WR;
                end
            end
        end
    end
    
    // Output assignment
    always @(state) begin
        if (state == WL) begin
            walk_left <= 1;
            walk_right <= 0;
        end else if (state == WR) begin
            walk_left <= 0;
            walk_right <= 1;
        end
    end
    
endmodule
