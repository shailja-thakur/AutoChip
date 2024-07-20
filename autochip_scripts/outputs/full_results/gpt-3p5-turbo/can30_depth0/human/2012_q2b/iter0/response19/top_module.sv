module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    
    reg [5:0] next_state, current_state;
    
    always @(posedge w) begin
        current_state <= y;
    end
    
    always @(current_state) begin
        case (current_state)
            6'b000001: begin  // A
                next_state = 6'b000001;
            end
            6'b000010: begin  // B
                next_state = w ? 6'b000100 : 6'b001000;
            end
            6'b000100: begin  // C
                next_state = w ? 6'b010000 : 6'b001000;
            end
            6'b001000: begin  // D
                next_state = w ? 6'b100000 : 6'b000001;
            end
            6'b010000: begin  // E
                next_state = w ? 6'b010000 : 6'b001000;
            end
            6'b100000: begin  // F
                next_state = w ? 6'b000100 : 6'b001000;
            end
        endcase
    end
    
    assign Y1 = next_state[1];
    assign Y3 = next_state[3];
    
endmodule
