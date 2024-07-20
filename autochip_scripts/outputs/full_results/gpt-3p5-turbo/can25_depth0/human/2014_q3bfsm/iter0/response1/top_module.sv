module top_module (
	input clk,
	input reset,
	input x,
	output reg z,
	output reg [2:0] y
);

reg [2:0] next_y;
reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;
    else
        state <= next_y;
end

always @(state or x) begin
    case (state)
        3'b000:
            if (x)
                next_y <= 3'b001;
            else 
                next_y <= 3'b000;
        3'b001:
            if (x)
                next_y <= 3'b100;
            else
                next_y <= 3'b001;
        3'b010:
            if (x)
                next_y <= 3'b001;
            else
                next_y <= 3'b010;
        3'b011:
            if (x)
                next_y <= 3'b010;
            else
                next_y <= 3'b001;
        3'b100:
            if (x)
                next_y <= 3'b100;
            else
                next_y <= 3'b011;
        default:
            next_y <= 3'b000;
    endcase
end

always @(posedge clk) begin
    case (state)
        3'b011: z <= 1'b1;
        3'b100: z <= 1'b1;
        default: z <= 1'b0;
    endcase
end

assign y = state;

endmodule
