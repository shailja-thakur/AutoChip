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

parameter FALL_COUNT_MAX = 20;

reg [4:0] fall_count;
reg prev_ground;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_count <= 0;
        prev_ground <= 1;
    end
    else begin
        prev_ground <= ground;

        // Handle falling
        if (!ground) begin
            aaah <= 1;
            fall_count <= fall_count + 1;
            walk_left <= walk_left;
            walk_right <= walk_right;
            digging <= 0;
        end
        else begin
            aaah <= 0;
            fall_count <= 0;
        end

        // Handle splattering
        if (fall_count >= FALL_COUNT_MAX && !ground) begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end

        // Handle walking
        if (ground) begin
            if (bump_left) begin
                walk_left <= 0;
                walk_right <= 1;
            end
            else if (bump_right) begin
                walk_left <= 1;
                walk_right <= 0;
            end
            else begin
                walk_left <= walk_left;
                walk_right <= walk_right;
            end
        end

        // Handle digging
        if (ground && !prev_ground && !fall_count) begin
            digging <= 1;
        end
        else if (!ground && digging) begin
            digging <= 0;
        end
        else begin
            digging <= digging;
        end
    end
end

endmodule
