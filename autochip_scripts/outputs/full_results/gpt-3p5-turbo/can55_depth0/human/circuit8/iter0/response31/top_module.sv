module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg state;

always @(posedge clock) begin
    case(state)
        0: begin
            if (a == 1'b0)
                state <= 1;
            else 
                state <= 0;
        end
        1: begin
            state <= 2;
            p <= 1'b0;
            q <= 1'b0;
        end
        2: begin
            state <= 3;
            p <= 1'b0;
            q <= 1'b0;
        end
        3: begin
            if (a == 1'b0) begin
                state <= 4;
                p <= 1'b0;
                q <= 1'b0;
            end
            else 
                state <= 3;
        end
        4: begin
            if (a == 1'b0) begin
                state <= 4;
                p <= 1'b0;
                q <= 1'b0;
            end
            else begin
                state <= 5;
                p <= 1'b0;
                q <= 1'b0;
            end
        end
        5: begin
            if (a == 1'b1) begin
                state <= 6;
                p <= 1'b1;
                q <= 1'b0;
            end
            else 
                state <= 5;
        end
        6: begin
            if (a == 1'b0) begin
                state <= 7;
                p <= 1'b0;
                q <= 1'b0;
            end
            else 
                state <= 6;
        end
        7: begin
            if (a == 1'b1) begin
                state <= 8;
                p <= 1'b1;
                q <= 1'b0;
            end
            else 
                state <= 7;
        end
        8: begin
            if (a == 1'b0) begin
                state <= 9;
                p <= 1'b0;
                q <= 1'b0;
            end
            else 
                state <= 8;
        end
        9: begin
            if (a == 1'b1) begin
                state <= 10;
                p <= 1'b1;
                q <= 1'b0;
            end
            else 
                state <= 9;
        end
        10: begin
            if (a == 1'b0) begin
                state <= 11;
                p <= 1'b0;
                q <= 1'b1;
            end
            else 
                state <= 10;
        end
        11: begin
            if (a == 1'b0) begin
                state <= 11;
                p <= 1'b0;
                q <= 1'b1;
            end
            else 
                state <= 0;
        end
    endcase
end

endmodule
