module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] y_next;
    reg [2:0] y_reg;

    always @(posedge clk) begin
        if (reset) begin
            y_reg <= 3'b000;
        end else begin
            y_reg <= y_next;
        end
    end

    always @(*) begin
        case(y_reg)
            3'b000: y_next = x ? 3'b001 : 3'b000;
            3'b001: y_next = x ? 3'b100 : 3'b001;
            3'b010: y_next = x ? 3'b001 : 3'b010;
            3'b011: y_next = x ? 3'b010 : 3'b001;
            3'b100: y_next = x ? 3'b100 : 3'b011;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            z <= 1'b0;
        end else begin
            case (y_reg)
                3'b011: z <= 1'b1;
                3'b100: z <= 1'b1;
                default: z <= 1'b0;
            endcase
        end
    end

endmodule
