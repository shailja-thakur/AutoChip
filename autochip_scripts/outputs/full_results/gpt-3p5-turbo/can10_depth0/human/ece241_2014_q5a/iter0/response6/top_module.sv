module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [2:0] state;
reg [2:0] next_state;
reg z;

parameter IDLE = 3'b000;
parameter CONVERSION = 3'b001;
parameter RESET = 3'b010;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= RESET;
    else
        state <= next_state;
end

always @(state or x) begin
    case (state)
        IDLE: begin
            if (~areset)
                next_state = CONVERSION;
            else
                next_state = IDLE;
            z = 1'b0;
        end

        CONVERSION: begin
            if (~areset)
                next_state = CONVERSION;
            else
                next_state = RESET;
            z = ~x + 1'b1;
        end

        RESET: begin
            next_state = IDLE;
            z = 1'b0;
        end
    endcase
end

endmodule
