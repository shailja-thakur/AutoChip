module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state, next_state;

// State transition logic
always @(posedge clk, posedge reset)
begin
    if (reset)
        state <= 3'b001;  // State A
    else
        state <= next_state;
end

// Output generation logic
always @(*)
begin
    case (state)
        3'b001: begin  // State A
            if (x)
                next_state = 3'b010;  // State B
            else
                next_state = 3'b001;  // State A
        end
        3'b010: begin  // State B
            if (x)
                next_state = 3'b101;  // State E
            else
                next_state = 3'b010;  // State B
        end
        3'b011: next_state = 3'b010;  // State C
        3'b100: next_state = 3'b010;  // State D
        3'b101: begin  // State E
            if (x)
                next_state = 3'b101;  // State E
            else
                next_state = 3'b100;  // State D
        end
        default: next_state = 3'b001;  // Default to State A
    endcase

    // Output is high when state is D or E
    if (state == 3'b100 || state == 3'b101)
        z = 1'b1;
    else
        z = 1'b0;
end

endmodule
