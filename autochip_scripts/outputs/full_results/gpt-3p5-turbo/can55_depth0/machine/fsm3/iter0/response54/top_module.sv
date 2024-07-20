module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
wire [1:0] next_state;

// Combinational logic block to determine next state
assign next_state =  ((state == 2'b00) && in) ? 2'b10 :
                    ((state == 2'b00) && !in) ? 2'b00 :
                    ((state == 2'b01) && in) ? 2'b01 :
                    ((state == 2'b01) && !in) ? 2'b10 :
                    ((state == 2'b10) && in) ? 2'b11 :
                    ((state == 2'b10) && !in) ? 2'b00 :
                    ((state == 2'b11) && in) ? 2'b01 :
                    2'b10;

// State register and output assignment
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00;
        out <= 1'b0; // Reset output to 0 when state is A
    end else begin
        state <= next_state;
        out <= (state == 2'b11) ? 1'b1 : 1'b0; // Set output to 1 when state is D, otherwise 0
    end
end

endmodule
