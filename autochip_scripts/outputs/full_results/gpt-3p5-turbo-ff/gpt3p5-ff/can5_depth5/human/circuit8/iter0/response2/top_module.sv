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
            if (a == 0) begin
                p <= 0;
                q <= 0;
                state <= 0;
            end
            else begin
                p <= 1;
                q <= 0;
                state <= 1;
            end
        end
        1: begin
            p <= 0;
            q <= 0;
            if (a == 0)
                state <= 2;
            else
                state <= 1;
        end
        2: begin
            p <= 1;
            q <= 0;
            if (a == 1) begin
                state <= 3;
                p <= 0;
            end
        end
        3: begin
            if (a == 0) begin
                p <= 1;
                q <= 1;
                state <= 4;
            end
            else begin
                p <= 0;
                q <= 1;
                state <= 3;
            end
        end
        4: begin
            if (a == 0) begin
                p <= 0;
                q <= 1;
                state <= 5;
            end
            else begin
                p <= 1;
                q <= 1;
                state <= 4;
            end
        end
        5: begin
            if (a == 0) begin
                p <= 0;
                q <= 1;
                state <= 5;
            end
            else begin
                p <= 1;
                q <= 1;
                state <= 6;
            end
        end
        6: begin
            if (a == 0) begin
                p <= 0;
                q <= 1;
                state <= 6;
            end
            else if (a == 1) begin
                p <= 0;
                q <= 1;
                state <= 7;
            end
        end
        7: begin
            if (a == 0) begin
                p <= 0;
                q <= 1;
                state <= 8;
            end
            else begin
                p <= 0;
                q <= 1;
                state <= 7;
            end
        end
        8: begin
            if (a == 0) begin
                p <= 0;
                q <= 1;
                state <= 9;
            end
            else if (a == 1) begin
                p <= 1;
                q <= 1;
                state <= 8;
            end
        end
        9: begin
            if (a == 0) begin
                p <= 0;
                q <= 1;
                state <= 10;
            end
            else begin
                p <= 1;
                q <= 1;
                state <= 9;
            end
        end
        10: begin
            if (a == 0) begin
                p <= 0;
                q <= 1;
                state <= 10;
            end
            else if (a == 1) begin
                p <= 1;
                q <= 1;
                state <= 11;
            end
        end
        11: begin
            p <= 0;
            q <= 1;
            state <= 12;
        end
        12: begin
            p <= 0;
            q <= 1;
            if (a == 1) begin
                p <= 0;
                q <= 1;
                state <= 13;
            end
            else begin
                p <= 0;
                q <= 0;
                state <= 12;
            end
        end
        13: begin
            if (a == 0) begin
                p <= 0;
                q <= 1;
                state <= 14;
            end
            else begin
                p <= 0;
                q <= 0;
                state <= 13;
            end
        end
        14: begin
            if (a == 0) begin
                p <= 0;
                q <= 1;
                state <= 14;
            end
            else begin
                p <= 0;
                q <= 1;
                state <= 15;
            end
        end
        15: begin
            if (a == 0) begin
                p <= 0;
                q <= 1;
                state <= 15;
            end
            else if (a == 1) begin
                p <= 0;
                q <= 1;
                state <= 16;
            end
        end
        16: begin
            if (a == 0) begin
                p <= 0;
                q <= 1;
                state <= 17;
            end
            else begin
                p <= 0;
                q <= 1;
                state <= 16;
            end
        end
        17: begin
            if (a == 0) begin
                p <= 1;
                q <= 0;
                state <= 0;
            end
            else begin
                p <= 0;
                q <= 1;
                state <= 17;
            end
        end
    endcase
end

endmodule
