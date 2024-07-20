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
    
    reg [2:0] state, next_state;
    
    localparam WL = 3'b000, WR = 3'b001, FALLWL = 3'b010, FALLWR = 3'b011, DIGWL = 3'b100, DIGWR = 3'b101;
    
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            state <= WL; // Asynchronous reset to walking left
        end else begin
            state <= next_state;
        end
    end
    
    always @ (*) begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case (state)
            WL: begin // Walking left
                walk_left = 1;
                if (!ground) begin
                    next_state = FALLWL;
                end else if (dig) begin
                    next_state = DIGWL;
                end else if (bump_left) begin
                    next_state = WR;
                end else begin
                    next_state = WL;
                end
            end
            
            WR: begin // Walking right
                walk_right = 1;
                if (!ground) begin
                    next_state = FALLWR;
                end else if (dig) begin
                    next_state = DIGWR;
                end else if (bump_right) begin
                    next_state = WL;
                end else begin
                    next_state = WR;
                end
            end
            
            FALLWL: begin // Falling from walking left
                aaah = 1;
                if (ground) begin
                    next_state = WL;
                end else begin
                    next_state = FALLWL;
                end
            end
            
            FALLWR: begin // Falling from walking right
                aaah = 1;
                if (ground) begin
                    next_state = WR;
                end else begin
                    next_state = FALLWR;
                end
            end
            
            DIGWL: begin // Digging while previously walking left
                digging = 1;
                if (!ground) begin
                    next_state = FALLWL;
                end else begin
                    next_state = DIGWL;
                end
            end
            
            DIGWR: begin // Digging while previously walking right
                digging = 1;
                if (!ground) begin
                    next_state = FALLWR;
                end else begin
                    next_state = DIGWR;
                end
            end
            
            default: next_state = WL;
        endcase
    end
endmodule
