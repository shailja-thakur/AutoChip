module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
wire next_state;

assign out = state[0];

always @(posedge clk) begin
    if (areset) begin
        state <= 2'b1;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case(state)
        2'b00: begin
            if(in) begin
                next_state = 2'b01;
            end else begin
                next_state = 2'b10;
            end
        end
        2'b01: begin
            next_state = 2'b00;
        end
        2'b10: begin
            if(in) begin
                next_state = 2'b11;
            end else begin
                next_state = 2'b00;
            end
        end
        2'b11: begin
            next_state = 2'b01;
        end
    endcase
end

endmodule
