module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    // Define the states
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;

    // Define the next state logic
    always @(*)
    begin
        case (y)
            A:
            begin
                if (w)
                    Y2 = 1'b0;
                else
                    Y2 = 1'b1;
            end

            B:
            begin
                if (w)
                    Y2 = 1'b1;
                else
                    Y2 = 1'b0;
            end

            C:
            begin
                if (w)
                    Y2 = 1'b0;
                else
                    Y2 = 1'b1;
            end

            D:
            begin
                if (w)
                    Y2 = 1'b1;
                else
                    Y2 = 1'b1;
            end

            E:
            begin
                if (w)
                    Y2 = 1'b0;
                else
                    Y2 = 1'b0;
            end

            F:
            begin
                if (w)
                    Y2 = 1'b1;
                else
                    Y2 = 1'b0;
            end
        endcase
    end
endmodule
