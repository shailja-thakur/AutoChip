module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

reg [1:0] state;
reg internal_output;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Initialize to walking left state
        internal_output <= 0; // Initialize internal output to 0
    end else begin
        case(state)
            2'b01: begin // Walking left state
                if (bump_right == 1) begin
                    state <= 2'b10; // Switch to walking right state
                    internal_output <= 1; // Set internal output to 1
                end
            end
            2'b10: begin // Walking right state
                if (bump_left == 1) begin
                    state <= 2'b01; // Switch to walking left state
                    internal_output <= 0; // Set internal output to 0
                end
            end
        endcase
    end
end

assign walk_left = (state == 2'b01) ? 1 : 0; // Set walk_left output based on current state
assign walk_right = (state == 2'b10) ? 1 : 0; // Set walk_right output based on current state

endmodule
