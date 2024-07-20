module top_module (
	input clk,
	input reset,
	input x,
	output reg z,
	output reg [2:0] y
);

reg [2:0] y_next;
reg [2:0] y_reg;

always @(posedge clk or posedge reset) begin
    if (reset)
        y_reg <= 0;
    else
        y_reg <= y_next;
end

always @* begin
    case (y_reg)
        3'b000: begin
            if (x)
                y_next = 3'b001;
            else
                y_next = 3'b000;
            z = 1'b0;
        end
        3'b001: begin
            if (x)
                y_next = 3'b100;
            else
                y_next = 3'b001;
            z = 1'b0;
        end
        3'b010: begin
            if (x)
                y_next = 3'b001;
            else
                y_next = 3'b010;
            z = 1'b0;
        end
        3'b011: begin
            if (x)
                y_next = 3'b010;
            else
                y_next = 3'b001;
            z = 1'b1;
        end
        3'b100: begin
            if (x)
                y_next = 3'b100;
            else
                y_next = 3'b011;
            z = 1'b1;
        end
    endcase
end

assign y = y_reg;

endmodule
