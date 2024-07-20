module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

reg [2:0] next_state;

always @(*) begin
    case (y)
        3'b000: begin
            if (x == 0) begin
                next_state = 3'b000;
            end else begin
                next_state = 3'b001;
            end
        end
        3'b001: begin
            if (x == 0) begin
                next_state = 3'b001;
            end else begin
                next_state = 3'b100;
            end
        end
        3'b010: begin
            if (x == 0) begin
                next_state = 3'b010;
            end else begin
                next_state = 3'b001;
            end
        end
        3'b011: begin
            if (x == 0) begin
                next_state = 3'b001;
            end else begin
                next_state = 3'b010;
            end
        end
        3'b100: begin
            if (x == 0) begin
                next_state = 3'b011;
            end else begin
                next_state = 3'b100;
            end
        end
        default: next_state = 3'b000; // Default state
    endcase
end

always @(posedge clk) begin
    Y0 <= next_state[0];
end

always @(*) begin
    case (y)
        3'b000, 3'b001, 3'b010: z = 0;
        3'b011, 3'b100: z = 1;
        default: z = 0;
    endcase
end

endmodule
