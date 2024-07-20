module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk) begin
    if (!resetn) begin
        state <= 2'b00;  // Initializing state A
    end else begin
        state <= next_state;
    end
end

always @(state or r) begin
    case (state)
        2'b00: begin
            if (r[1]) begin
                next_state = 2'b01;  // Transition to state B if r[1] is high
            end else if (r[2]) begin
                next_state = 2'b10;  // Transition to state C if r[2] is high
            end else if (r[3]) begin
                next_state = 2'b11;  // Transition to state D if r[3] is high
            end else begin
                next_state = 2'b00;  // Transition to state A if none of the bits of r are high
            end
        end
        
        2'b01: begin
            if (r[1]) begin
                next_state = 2'b01;  // Stay in state B if r[1] is high
            end else begin
                next_state = 2'b00;  // Transition to state A otherwise
            end
        end
        
        2'b10: begin
            if (r[2]) begin
                next_state = 2'b10;  // Stay in state C if r[2] is high
            end else begin
                next_state = 2'b00;  // Transition to state A otherwise
            end
        end
        
        2'b11: begin
            if (r[3]) begin
                next_state = 2'b11;  // Stay in state D if r[3] is high
            end else begin
                next_state = 2'b00;  // Transition to state A otherwise
            end
        end
    endcase
    
end

always @(state) begin
    case (state)
        2'b01: g[1] = 1'b1;  // Set g[1] high if current state is B
        2'b10: g[2] = 1'b1;  // Set g[2] high if current state is C
        2'b11: g[3] = 1'b1;  // Set g[3] high if current state is D
        default: g = 3'b000;  // Set all bits of g low otherwise
    endcase
end

endmodule
