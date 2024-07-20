module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 0;
    end else begin
        state <= next_state;
    end
end

always @(state, in) begin
    case (state)
        2'b00: begin
            if (in) begin
                next_state = 2'b00;
            end else begin
                next_state = 2'b01;
            end
        end
        
        2'b01: begin
            if (in) begin
                next_state = 2'b01;
            end else begin
                next_state = 2'b00;
            end
        end
    endcase
end

assign out = (state == 2'b01);

endmodule
