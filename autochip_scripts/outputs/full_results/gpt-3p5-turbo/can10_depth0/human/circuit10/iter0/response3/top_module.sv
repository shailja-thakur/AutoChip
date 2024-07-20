module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);
reg q;
reg state;

always @(posedge clk) begin
    if (state == 0) begin
        if (a == 0 && b == 0)
            state <= 0;
        else if (a == 0 && b == 1)
            state <= 1;
        else if (a == 1 && b == 0)
            state <= 2;
        else if (a == 1 && b == 1)
            state <= 3;
    end else if (state == 1) begin
        if (a == 0 && b == 0)
            state <= 0;
        else if (a == 0 && b == 1)
            state <= 1;
        else if (a == 1 && b == 0)
            state <= 2;
        else if (a == 1 && b == 1)
            state <= 3;
    end else if (state == 2) begin
        if (a == 0 && b == 0)
            state <= 0;
        else if (a == 0 && b == 1)
            state <= 1;
        else if (a == 1 && b == 0)
            state <= 2;
        else if (a == 1 && b == 1)
            state <= 3;
    end else if (state == 3) begin
        if (a == 0 && b == 0)
            state <= 0;
        else if (a == 0 && b == 1)
            state <= 1;
        else if (a == 1 && b == 0)
            state <= 2;
        else if (a == 1 && b == 1)
            state <= 3;
    end
end

always @(state) begin
    case (state)
        0: begin
            q <= 0;
            state <= 0;
        end
        1: begin
            q <= 1;
            state <= 1;
        end
        2: begin
            q <= 1;
            state <= 2;
        end
        3: begin
            q <= 0;
            state <= 3;
        end
    endcase
end

endmodule
