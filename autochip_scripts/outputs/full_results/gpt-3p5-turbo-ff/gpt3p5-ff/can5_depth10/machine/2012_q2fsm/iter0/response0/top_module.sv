module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
wire z;

// Synchronous Reset
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;
    else
        state <= next_state;
end

// Combinational Logic for next_state
reg [2:0] next_state;
always @(*) begin
    case(state)
        3'b000: if (w) next_state = 3'b001; else next_state = 3'b000;
        3'b001: if (w) next_state = 3'b010; else next_state = 3'b010;
        3'b010: if (w) next_state = 3'b100; else next_state = 3'b011;
        3'b011: if (w) next_state = 3'b000; else next_state = 3'b011;
        3'b100: if (w) next_state = 3'b100; else next_state = 3'b011;
        3'b101: if (w) next_state = 3'b101; else next_state = 3'b110;
        default: next_state = 3'b000;
    endcase
end

// Assign Output
assign z = (state == 3'b100) || (state == 3'b101);

endmodule
