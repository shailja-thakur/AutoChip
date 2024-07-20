module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] y, y_next;

    always @(posedge clk or posedge reset) begin
        if (reset)
            y <= 3'b000;
        else
            y <= y_next;
    end

    always @* begin
        case (y)
            3'b000:
                if (x)
                    y_next = 3'b001;
                else
                    y_next = 3'b000;
            3'b001:
                if (x)
                    y_next = 3'b100;
                else
                    y_next = 3'b001;
            3'b010:
                if (x)
                    y_next = 3'b001;
                else
                    y_next = 3'b010;
            3'b011:
                if (x)
                    y_next = 3'b010;
                else
                    y_next = 3'b001;
            3'b100:
                if (x)
                    y_next = 3'b100;
                else
                    y_next = 3'b011;
            default:
                y_next = 3'b000;
        endcase
    end

    always @* begin
        case (y)
            3'b011, 3'b100:
                z = 1'b1;
            default:
                z = 1'b0;
        endcase
    end

endmodule
