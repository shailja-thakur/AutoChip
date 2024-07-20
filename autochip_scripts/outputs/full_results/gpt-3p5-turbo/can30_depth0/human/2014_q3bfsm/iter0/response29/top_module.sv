module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] y;
reg [2:0] next_y;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        y <= 3'b000;
        z <= 1'b0;
    end else begin
        y <= next_y;
        z <= (y == 3'b011);
    end
end

always @(*) begin
    case (y)
        3'b000: begin
            if (x) begin
                next_y = 3'b001;
            end else begin
                next_y = 3'b000;
            end
        end
        3'b001: begin
            if (x) begin
                next_y = 3'b100;
            end else begin
                next_y = 3'b001;
            end
        end
        3'b010: begin
            if (x) begin
                next_y = 3'b001;
            end else begin
                next_y = 3'b010;
            end
        end
        3'b011: begin
            if (x) begin
                next_y = 3'b010;
            end else begin
                next_y = 3'b001;
            end
        end
        3'b100: begin
            if (x) begin
                next_y = 3'b100;
            end else begin
                next_y = 3'b011;
            end
        end
    endcase
end

endmodule
