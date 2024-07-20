module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b10; // Initialize state to walk_left
        else begin
            case (state)
                2'b10: begin // State: walk_left
                    if (bump_right) begin
                        state <= 2'b01; // Next state: walk_right
                        walk_right <= 1; // Output: walk_right
                    end
                end
                
                2'b01: begin // State: walk_right
                    if (bump_left) begin
                        state <= 2'b10; // Next state: walk_left
                        walk_left <= 1; // Output: walk_left
                    end
                end
            endcase
        end
    end
    
    // Default assignments for outputs
    always @(state) begin
        walk_left <= 0;
        walk_right <= 0;
    end

endmodule
