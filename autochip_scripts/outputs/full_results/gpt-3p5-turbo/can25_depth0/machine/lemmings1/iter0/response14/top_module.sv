module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    // Internal state register
    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b11; // Initialize state to WL
        end else begin
            case(state)
                2'b00: // WL state
                    if(bump_left) begin
                        state <= 2'b01; // Next state is WR
                    end
                    else begin
                        state <= 2'b00; // Next state is WL
                    end
                    
                2'b01: // WR state
                    if(bump_right) begin
                        state <= 2'b00; // Next state is WL
                    end
                    else begin
                        state <= 2'b01; // Next state is WR
                    end
                    
                default: // Should never reach default state
                    state <= 2'b11; // Reset state to WL
            endcase
        end
    end

    // Assign outputs based on current state
    assign walk_left = (state == 2'b00);
    assign walk_right = (state == 2'b01);

endmodule
