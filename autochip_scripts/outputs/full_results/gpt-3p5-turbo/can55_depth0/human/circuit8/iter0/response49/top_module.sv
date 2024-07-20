module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg state;

always @(posedge clock) begin
    case (state)
        0: begin
            if (a == 1'b0)
                state <= 1;
            else
                state <= 0;
        end
        1: begin
            if (a == 1'b0)
                state <= 2;
            else
                state <= 1;
        end
        2: begin
            if (a == 1'b0)
                state <= 3;
            else
                state <= 2;
        end
        3: begin
            if (a == 1'b1)
                state <= 4;
            else
                state <= 3;
        end
        4: begin
            if (a == 1'b0)
                state <= 5;
            else
                state <= 4;
        end
        5: begin
            if (a == 1'b1)
                state <= 6;
            else
                state <= 5;
        end
        6: begin
            if (a == 1'b0)
                state <= 7;
            else
                state <= 6;
        end
        7: begin
            if (a == 1'b1)
                state <= 8;
            else
                state <= 7;
        end
        8: begin
            if (a == 1'b0)
                state <= 0;
            else
                state <= 8;
        end
    endcase

    // Output assignments
    case (state)
        0: begin
            p <= 1'b0;
            q <= 1'b0;
        end
        1: begin
            p <= 1'b0;
            q <= 1'b0;
        end
        2: begin
            p <= 1'b0;
            q <= 1'b0;
        end
        3: begin
            p <= 1'b0;
            q <= 1'b0;
        end
        4: begin
            p <= 1'b0;
            q <= 1'b0;
        end
        5: begin
            p <= 1'b0;
            q <= 1'b0;
        end
        6: begin
            p <= 1'b0;
            q <= 1'b0;
        end
        7: begin
            p <= 1'b0;
            q <= 1'b0;
        end
        8: begin
            p <= 1'b0;
            q <= 1'b1;
        end
    endcase
end

endmodule
