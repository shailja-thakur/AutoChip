module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;  // initialize state to A
    else
        state <= next_state;  // update state based on next_state
end

always @* begin
    case (state)
        3'b000: begin  // state A
            if (x)
                next_state = 3'b010;  // next state B
            else
                next_state = state;  // next state A
        end
        
        3'b001: begin  // state B
            if (x)
                next_state = 3'b100;  // next state E
            else
                next_state = state;  // next state B
        end
        
        3'b010: begin  // state C
            if (x)
                next_state = 3'b010;  // next state B
            else
                next_state = state;  // next state C
        end
        
        3'b011: begin  // state D
            if (x)
                next_state = 3'b010;  // next state C
            else
                next_state = state;  // next state D
        end
        
        3'b100: begin  // state E
            if (x)
                next_state = 3'b100;  // next state E
            else
                next_state = 3'b011;  // next state D
        end
        
        default: next_state = state;  // default case, no state transition
    endcase
end

always @* begin
    if (state == 3'b100 || state == 3'b101)
        z = 1'b1;  // output is high when state is D or E
    else
        z = 1'b0;
end

endmodule
