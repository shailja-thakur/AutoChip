module top_module (
	input wire clk,
	input wire areset,
	input wire bump_left,
	input wire bump_right,
	output wire walk_left,
	output wire walk_right
);

    // Parameters
    parameter WL = 0;
    parameter WR = 1;

    // Registers
    reg [1:0] state;

    // Combinational Logic
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            state <= WL;
        end else begin
            if (state == WL) begin
                state <= (bump_left) ? WR : WL;
            end else begin
                state <= (bump_right) ? WL : WR;
            end
        end
    end

    // Output Assignment
    assign walk_left = (state == WL) ? 1'b1 : 1'b0;
    assign walk_right = (state == WR) ? 1'b1 : 1'b0;

endmodule
