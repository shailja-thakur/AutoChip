module top_module (
    input wire clock,
    input wire a,
    output reg p,
    output reg q
);

    reg state;

    always @(posedge clock) begin
        if (state == 0)
            p <= 0;
        else if (state == 1)
            p <= 1;
        else if (state == 2)
            p <= a;
        else if (state == 3)
            p <= a;
    end

    always @(posedge clock) begin
        if (state == 0)
            q <= 0;
        else if (state == 1)
            q <= 0;
        else if (state == 2)
            q <= 0;
        else if (state == 3)
            q <= 1;
    end

    always @(posedge clock) begin
        if (state == 0 && a == 1)
            state <= 1;
        else if (state == 1)
            state <= 2;
        else if (state == 2 && a == 0)
            state <= 3;
        else if (state == 3 && a == 1)
            state <= 0;
    end
endmodule
