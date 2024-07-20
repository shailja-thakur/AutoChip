module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);
    
    reg [3:0] state;
    reg start_digging;
    reg [4:0] fall_counter;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 4'b0000;
            start_digging <= 1'b0;
            fall_counter <= 5'b00000;
        end else begin
            case (state)
                4'b0000: begin // Walking left
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                    
                    if (ground) begin
                        if (bump_left || (bump_left && bump_right)) begin
                            state <= 4'b0010; // Switching direction
                        end else if (dig) begin
                            start_digging <= 1'b1;
                            state <= 4'b0001; // Starting to dig
                        end
                    end else begin
                        aaah <= 1'b1;
                        state <= 4'b0100; // Falling
                    end
                end
                4'b0001: begin // Digging
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b1;
                    
                    if (!ground || start_digging) begin
                        state <= 4'b0100; // Falling
                    end else if (bump_left || (bump_left && bump_right)) begin
                        state <= 4'b0010; // Switching direction
                    end
                end
                4'b0010: begin // Switching direction
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                    
                    if (ground) begin
                        if (bump_right || (bump_left && bump_right)) begin
                            state <= 4'b0010; // Still switching direction
                        end else begin
                            state <= 4'b0000; // Walking left
                        end
                    else begin
                        aaah <= 1'b1;
                        state <= 4'b0100; // Falling
                    end
                end
                4'b0100: begin // Falling
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b1;
                    digging <= 1'b0;
                    
                    if (fall_counter == 5'b11111) begin
                        fall_counter <= 5'b00000;
                        if (ground) begin
                            state <= 4'b0000; // Walking left
                        end
                    end else begin
                        fall_counter <= fall_counter + 1'b1;
                    end
                end
            endcase
        end
    end
endmodule
