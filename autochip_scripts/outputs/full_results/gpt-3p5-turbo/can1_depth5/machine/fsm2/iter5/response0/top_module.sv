module top_module (
    input wire clk,
    input wire j,
    input wire k,
    input wire areset,
    output reg out
);

reg [1:0] current_state;
reg [1:0] next_state;

initial begin
    out = 1'b0; // Initialize out to 0
end

always_comb begin
    case (current_state)
        2'b00: begin
            if (j) begin
                next_state = 2'b01;
            end else begin
                next_state = 2'b00;
            end
        end
        2'b01: begin
            if (k) begin
                next_state = 2'b00;
            end else begin
                next_state = 2'b01;
            end
        end
        default: next_state = 2'b00;
    endcase
end

always @(posedge clk or posedge areset) begin
	if (areset) begin
		current_state <= 2'b00;
		out <= 1'b0; // Reset out to 0 when areset is high
	end else begin
		current_state <= next_state;
		if (next_state == 2'b01) begin
			out <= 1'b1;
		end else begin
			out <= 1'b0;
		end
	end
end

endmodule
