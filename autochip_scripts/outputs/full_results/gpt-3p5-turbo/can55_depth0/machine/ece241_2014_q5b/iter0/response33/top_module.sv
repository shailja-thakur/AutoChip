module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
wire rising_edge;
assign rising_edge = x & ~x;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else begin
        case (state)
            A: begin
                   if (rising_edge)
                       state <= B;
                   else
                       state <= A;
               end
            B: state <= B;
            default: state <= A;
        endcase
    end
end

assign z = (state == A && x) || (state == B && ~x);

endmodule
