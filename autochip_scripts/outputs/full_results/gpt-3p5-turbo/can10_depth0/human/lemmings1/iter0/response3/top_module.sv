module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    
    reg [1:0] state;
    
    always @ (posedge clk, posedge areset)
    begin
        if (areset)
            state <= 2'b10;  // Set initial state to walk left
        else
        begin
            case(state)
                2'b10:  // State for walking left
                    begin
                        if (bump_right)
                            state <= 2'b01;  // Switch to state for walking right
                    end
                2'b01:  // State for walking right
                    begin
                        if (bump_left)
                            state <= 2'b10;  // Switch to state for walking left
                    end
            endcase
        end
    end
    
    always @ (state)
    begin
        case(state)
            2'b10:  // State for walking left
                begin
                    walk_left = 1;
                    walk_right = 0;
                end
            2'b01:  // State for walking right
                begin
                    walk_left = 0;
                    walk_right = 1;
                end
        endcase
    end
endmodule
