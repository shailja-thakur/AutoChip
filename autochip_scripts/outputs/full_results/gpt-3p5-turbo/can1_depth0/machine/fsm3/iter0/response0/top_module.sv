module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00;  // reset to state A
    else
        state <= next_state;
end

always @* begin
    case (state)
        2'b00: begin  // state A
            if (in)
                next_state = 2'b01;  // next state is B
            else
                next_state = 2'b00;  // next state is A
        end
        2'b01: begin  // state B
            if (in)
                next_state = 2'b01;  // next state is B
            else
                next_state = 2'b10;  // next state is C
        end
        2'b10: begin  // state C
            if (in)
                next_state = 2'b11;  // next state is D
            else
                next_state = 2'b00;  // next state is A
        end
        2'b11: begin  // state D
            if (in)
                next_state = 2'b01;  // next state is B
            else
                next_state = 2'b10;  // next state is C
        end
        default: next_state = 2'b00;
    endcase
end

always @(posedge clk) begin
    if (state == 2'b11)  // state D
        out <= 1'b1;
    else
        out <= 1'b0;
end

endmodule
