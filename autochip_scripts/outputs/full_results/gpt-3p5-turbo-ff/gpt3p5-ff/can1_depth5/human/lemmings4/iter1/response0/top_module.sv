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
    reg [4:0] state;
    reg fall; // Added reg for tracking falling state
    reg [4:0] fall_count; // Added reg for counting fall cycles
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 5'b00000; // Initial state: walking left 
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
            fall <= 0;
            fall_count <= 0;
        end else begin
            case (state)
                5'b00000: begin // Walking left
                    if (bump_right) begin
                        state <= 5'b00001; // Switch direction
                        walk_left <= 0;
                        walk_right <= 1;
                    end else if (bump_left) begin
                        state <= 5'b00010; // Switch direction
                        walk_left <= 1;
                        walk_right <= 0;
                    end else if (~ground) begin
                        state <= 5'b00100; // Falling
                        fall <= 1; // Start falling
                        fall_count <= 0; // Reset fall count
                        walk_left <= 0;
                        walk_right <= 0;
                    end else if (dig) begin
                        state <= 5'b01000; // Digging
                        walk_left <= 0;
                        walk_right <= 0;
                    end
                end
                5'b00001: begin // Walking right
                    if (bump_left) begin
                        state <= 5'b00010; // Switch direction
                        walk_left <= 1;
                        walk_right <= 0;
                    end else if (~ground) begin
                        state <= 5'b00100; // Falling
                        fall <= 1; // Start falling
                        fall_count <= 0; // Reset fall count
                        walk_left <= 0;
                        walk_right <= 0;
                    end else if (dig) begin
                        state <= 5'b01000; // Digging
                        walk_left <= 0;
                        walk_right <= 0;
                    end
                end
                5'b00010: begin // Walking left
                    if (bump_right) begin
                        state <= 5'b00001; // Switch direction
                        walk_left <= 0;
                        walk_right <= 1;
                    end else if (~ground) begin
                        state <= 5'b00100; // Falling
                        fall <= 1; // Start falling
                        fall_count <= 0; // Reset fall count
                        walk_left <= 0;
                        walk_right <= 0;
                    end else if (dig) begin
                        state <= 5'b01000; // Digging
                        walk_left <= 0;
                        walk_right <= 0;
                    end
                end
                5'b00100, 5'b00101, 5'b00110, 5'b00111: begin // Falling
                    if (~ground) begin
                        state <= state + 1;
                        fall_count <= fall_count + 1; // Increment fall count
                    end else begin
                        if (fall_count > 20) begin // Splatter if fall count exceeds 20
                            state <= 5'b01100; // Splatter state
                            walk_left <= 0;
                            walk_right <= 0;
                            aaah <= 0;
                            digging <= 0;
                        end else begin
                            state <= 5'b00000; // Walking left
                            walk_left <= 1;
                            walk_right <= 0;
                            fall <= 0; // Stop falling
                        end
                    end
                end
                5'b01000, 5'b01001, 5'b01010, 5'b01011: begin // Digging
                    if (~ground) begin
                        state <= state + 1;
                    end else begin
                        state <= 5'b00000; // Walking left
                        walk_left <= 1;
                        walk_right <= 0;
                    end
                end
            endcase
        end
    end
    
    always @(state, fall) begin
        if (state >= 5'b01100) begin // Splatter
            aaah <= 0;
            digging <= 0;
        end else begin
            aaah <= (fall && ~ground); // aaah! while falling
            digging <= ((state >= 5'b01000) && (state <= 5'b01011)); // Digging
        end
    end
endmodule
