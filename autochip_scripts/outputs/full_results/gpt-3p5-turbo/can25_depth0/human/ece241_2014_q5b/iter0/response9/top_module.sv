module top_module (
	input clk,
	input areset,
	input x,
	output z
);

// States
parameter A = 2'b00;
parameter B = 2'b01;

reg [1:0] state, next_state;
assign z = (state == B) ? 1'b1 : 1'b0;

always @(posedge clk or posedge areset)
begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @*
begin
    case (state)
        A: begin
            if (x)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (x)
                next_state = B;
            else
                next_state = A;
        end
        default: next_state = A;
    endcase
end

endmodule
