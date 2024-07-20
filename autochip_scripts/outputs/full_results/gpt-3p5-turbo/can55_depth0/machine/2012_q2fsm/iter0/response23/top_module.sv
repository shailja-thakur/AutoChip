module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    
reg [2:0] state, next_state;

// Synchronous reset to initial state A
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000; // initial state A
    else
        state <= next_state;
end

// Next state logic
always @* begin
    case (state)
        3'b000: if (w) next_state = 3'b001; else next_state = 3'b000;
        3'b001: if (w) next_state = 3'b010; else next_state = 3'b010;
        3'b010: if (w) next_state = 3'b100; else next_state = 3'b011;
        3'b011: if (w) next_state = 3'b001; else next_state = 3'b000;
        3'b100: if (w) next_state = 3'b100; else next_state = 3'b011;
        3'b101: if (w) next_state = 3'b101; else next_state = 3'b011;
    endcase
end

// Output assignment
always @* begin
    if (state == 3'b100 || state == 3'b101)
        z = 1'b1;
    else
        z = 1'b0;
end

endmodule
