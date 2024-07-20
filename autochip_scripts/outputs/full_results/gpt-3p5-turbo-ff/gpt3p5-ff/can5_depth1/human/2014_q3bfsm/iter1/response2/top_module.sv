module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] current_state, next_state;

always @(posedge clk or posedge reset)
begin
    if (reset)
        current_state <= 3'b000;
    else
        current_state <= next_state;
end

always @(current_state or x)
begin
    case (current_state)
        3'b000: if (x) next_state = 3'b001; else next_state = 3'b000;
        3'b001: if (x) next_state = 3'b100; else next_state = 3'b001;
        3'b010: if (x) next_state = 3'b001; else next_state = 3'b010;
        3'b011: if (x) next_state = 3'b010; else next_state = 3'b001;
        3'b100: if (x) next_state = 3'b100; else next_state = 3'b011;
        default: next_state = 3'b000;
    endcase
end

always @(current_state)
begin
    case (current_state)
        3'b000: z <= 1'b0;
        3'b011: z <= 1'b1;
        3'b100: z <= 1'b1;
        default: z <= 1'b0;
    endcase
end
  
endmodule
