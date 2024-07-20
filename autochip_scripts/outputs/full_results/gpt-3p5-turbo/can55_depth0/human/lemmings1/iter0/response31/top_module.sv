module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b1;  // Reset the state to walk left
        end else begin
            case (state)
                2'b00: begin  // State: walking right
                    if (bump_left && bump_right) begin
                        state <= 2'b01;  // Switch to state: walking left
                    end else if (bump_left) begin
                        state <= 2'b01;  // Switch to state: walking left
                    end
                end
                
                2'b01: begin  // State: walking left
                    if (bump_left && bump_right) begin
                        state <= 2'b00;  // Switch to state: walking right
                    end else if (bump_right) begin
                        state <= 2'b00;  // Switch to state: walking right
                    end
                end
            endcase
        end
    end
    
    assign walk_left = (state == 2'b01);
    assign walk_right = (state == 2'b00);

endmodule
