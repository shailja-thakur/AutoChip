module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

reg [5:0] next_state;
reg [5:0] current_state;

always @(y or w) begin
    case(current_state)
        // State A
        6'b000001: begin
            if (w)
                next_state = 6'b000010; // Transition to state B (Y1 = 0, Y3 = 0)
            else
                next_state = 6'b000001; // Transition to state A (Y1 = 0, Y3 = 0)
        end
        
        // State B
        6'b000010: begin
            if (w)
                next_state = 6'b000100; // Transition to state C (Y1 = 0, Y3 = 0)
            else
                next_state = 6'b001000; // Transition to state D (Y1 = 0, Y3 = 0)
        end
        
        // State C
        6'b000100: begin
            if (w)
                next_state = 6'b010000; // Transition to state E (Y1 = 1, Y3 = 0)
            else
                next_state = 6'b001000; // Transition to state D (Y1 = 0, Y3 = 0)
        end
        
        // State D
        6'b001000: begin
            if (w)
                next_state = 6'b100000; // Transition to state F (Y1 = 1, Y3 = 0)
            else
                next_state = 6'b000001; // Transition to state A (Y1 = 0, Y3 = 0)
        end
        
        // State E
        6'b010000: begin
            if (w)
                next_state = 6'b010000; // Transition to state E (Y1 = 1, Y3 = 0)
            else
                next_state = 6'b001000; // Transition to state D (Y1 = 0, Y3 = 0)
        end
        
        // State F
        6'b100000: begin
            if (w)
                next_state = 6'b000100; // Transition to state C (Y1 = 0, Y3 = 0)
            else
                next_state = 6'b001000; // Transition to state D (Y1 = 0, Y3 = 0)
        end
        
        // Default state
        default: next_state = 6'b000001; // Transition to state A (Y1 = 0, Y3 = 0)
    endcase
end

always @(posedge w) begin
    current_state <= next_state;
end

assign Y1 = (current_state == 6'b010000) || (current_state == 6'b100000);
assign Y3 = (current_state == 6'b010000);

endmodule
