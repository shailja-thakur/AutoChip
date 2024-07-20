module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;
    else
        state <= next_state;
end

always @* begin
    case (state)
        3'b000: begin // State A
            if (x)
                next_state = 3'b001; // Next State B
            else
                next_state = 3'b000; // Next State A
        end
        
        3'b001: begin // State B
            if (x)
                next_state = 3'b100; // Next State E
            else
                next_state = 3'b001; // Next State B
        end
        
        3'b010: begin // State C
            if (x)
                next_state = 3'b001; // Next State B
            else
                next_state = 3'b010; // Next State C
        end
        
        3'b011: begin // State D
            if (x)
                next_state = 3'b010; // Next State C
            else
                next_state = 3'b001; // Next State B
        end
        
        3'b100: begin // State E
            if (x)
                next_state = 3'b100; // Next State E
            else
                next_state = 3'b011; // Next State D
        end
        
        default: next_state = 3'b000;
    endcase
end

always @* begin
    if (state == 3'b011 || state == 3'b100)
        z = 1'b1; // Output is high when state is D or E
    else
        z = 1'b0;
end

endmodule
