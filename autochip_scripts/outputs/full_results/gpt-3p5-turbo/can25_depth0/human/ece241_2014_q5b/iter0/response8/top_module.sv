module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state, next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or negedge areset) 
    if (areset)
        state <= A;
    else
        state <= next_state;

always @* begin
    next_state = state;
    case (state)
        A: begin
            if (x == 1'b0)
                next_state = A;
            else
                next_state = B;
        end
        B: begin
            if (x == 1'b0)
                next_state = B;
            else
                next_state = B;
        end
    endcase
end

assign z = (state == B) ? 1'b0 : 1'b1;

endmodule
