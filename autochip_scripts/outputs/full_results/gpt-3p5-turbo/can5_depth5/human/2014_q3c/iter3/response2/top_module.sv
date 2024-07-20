module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

reg [2:0] Y;
reg [2:0] next_state;

always @(posedge clk) begin
    case (y)
        3'b000: begin
            if (x)
                next_state <= 3'b001;
            else
                next_state <= 3'b000;
            z <= 1'b0;
        end
        3'b001: begin
            if (x)
                next_state <= 3'b100;
            else
                next_state <= 3'b001;
            z <= 1'b0;
        end
        3'b010: begin
            if (x)
                next_state <= 3'b001;
            else
                next_state <= 3'b010;
            z <= 1'b0;
        end
        3'b011: begin
            if (x)
                next_state <= 3'b010;
            else
                next_state <= 3'b001;
            z <= 1'b1;
        end
        3'b100: begin
            if (x)
                next_state <= 3'b100;
            else
                next_state <= 3'b011;
            z <= 1'b1;
        end
        default: begin
            next_state <= 3'b000;
            z <= 1'b0;
        end
    endcase
end

always @(posedge clk) begin
    Y <= next_state;
end

assign Y0 = Y[0];

endmodule
