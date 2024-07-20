module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    // Define the next-state logic
    always @* begin
        case (y)
            // Specify the next state based on the current state and input
            3'b000:
                Y2 = 1'b0;
            3'b001:
                if (w)
                    Y2 = 1'b1;
                else
                    Y2 = 1'b0;
            3'b010:
                Y2 = 1'b0;
            3'b011:
                Y2 = 1'b1;
            3'b100:
                if (w)
                    Y2 = 1'b0;
                else
                    Y2 = 1'b1;
            3'b101:
                Y2 = 1'b1;
            default:
                Y2 = 1'b0;
        endcase
    end

endmodule
