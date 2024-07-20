module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Declare internal wires for the state transitions
wire [5:0] next_y;

// Generate the next state based on the current state and input
always @(*) begin
    case (y)
        6'b000001: next_y = w ? 6'b000010 : 6'b000001;
        6'b000010: next_y = w ? 6'b000100 : 6'b000001;
        6'b000100: next_y = w ? 6'b001000 : 6'b001000;
        6'b001000: next_y = w ? 6'b010000 : 6'b000010;
        6'b010000: next_y = w ? 6'b100000 : 6'b001000;
        6'b100000: next_y = w ? 6'b000100 : 6'b001000;
        default: next_y = 6'b000001;
    endcase
end

// Instantiate flip-flops for Y1 and Y3
reg Y1_reg, Y3_reg;

// Assign the outputs to the flip-flop inputs
always @(posedge clk) begin
    Y1_reg <= y[1];
    Y3_reg <= y[3];
end

// Assign the flip-flop outputs to the module outputs
assign Y1 = Y1_reg;
assign Y3 = Y3_reg;

endmodule
