module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

// Declare the output reg for the next state logic
reg [3:1] next_state;

// Combinational logic for next state
always @*
begin
    case(y)
        3'b000:
            next_state = w ? 3'b001 : 3'b000;
        3'b001:
            next_state = w ? 3'b110 : 3'b010;
        3'b010:
            next_state = w ? 3'b101 : 3'b011;
        3'b011:
            next_state = w ? 3'b111 : 3'b100;
        3'b100:
            next_state = w ? 3'b100 : 3'b101;
        3'b101:
            next_state = w ? 3'b011 : 3'b110;
        3'b110:
            next_state = w ? 3'b010 : 3'b111;
        3'b111:
            next_state = w ? 3'b100 : 3'b001;
    endcase
end

// Assign the output Y2 as y[2]
assign Y2 = next_state[2];

endmodule
