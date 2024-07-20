module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
wire clk_edge;

// Clock Edge Detection
always @(posedge clk)
    clk_edge <= ~clk_edge;

// State Transitions
always @(posedge clk_edge or posedge reset)
begin
    if (reset)
        state <= 3'b000; // Transition to state A when reset is high
    else
    begin
        case (state)
            3'b000: if (w) state <= 3'b000; else state <= 3'b001; // Transition to state A or B
            3'b001: if (w) state <= 3'b011; else state <= 3'b010; // Transition to state D or C
            3'b010: if (w) state <= 3'b011; else state <= 3'b100; // Transition to state D or E
            3'b011: if (w) state <= 3'b000; else state <= 3'b101; // Transition to state A or F
            3'b100: if (w) state <= 3'b011; else state <= 3'b100; // Transition to state D or E
            3'b101: if (w) state <= 3'b011; else state <= 3'b010; // Transition to state D or C
            default: state <= 3'b000; // Default state is A
        endcase
    end
end

// Output Assignment
always @(*)
begin
    case (state)
        3'b100, 3'b101: z <= 1'b1; // Output is high in state E and F
        default: z <= 1'b0; // Output is low in other states
    endcase
end

endmodule
