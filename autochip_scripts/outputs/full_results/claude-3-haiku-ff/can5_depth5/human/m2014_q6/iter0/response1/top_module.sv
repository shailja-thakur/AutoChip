module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state, next_state;

always @(posedge clk, posedge reset) begin
    if (reset)
        state <= 3'b000;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        3'b000: // State A
            if (w)
                next_state = 3'b000;
            else
                next_state = 3'b001;
        3'b001: // State B
            if (w)
                next_state = 3'b011;
            else
                next_state = 3'b010;
        3'b010: // State C
            if (w)
                next_state = 3'b011;
            else
                next_state = 3'b100;
        3'b011: // State D
            if (w)
                next_state = 3'b000;
            else
                next_state = 3'b101;
        3'b100: // State E
            if (w)
                next_state = 3'b011;
            else
                next_state = 3'b100;
        3'b101: // State F
            if (w)
                next_state = 3'b011;
            else
                next_state = 3'b010;
        default:
            next_state = 3'b000;
    endcase
end

assign z = (state == 3'b100 || state == 3'b101); // Output z is high in states E and F

endmodule
