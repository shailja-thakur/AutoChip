module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

    reg [1:0] state, next;
    parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

    always @(posedge clk) begin
        if (!resetn)
            state <= A;
        else
            state <= next;
    end

    always @(*) begin
        next = A;
        case (state)
            A: begin
                if (r[0])
                    next = B;
                else if (r[1])
                    next = C;
                else if (r[2])
                    next = D;
            end
            B: begin
                if (r[0])
                    next = B;
                else
                    next = A;
            end
            C: begin
                if (r[1])
                    next = C;
                else
                    next = A;
            end
            D: begin
                if (r[2])
                    next = D;
                else
                    next = A;
            end
        endcase
    end

    always @(*) begin
        g = 3'b000;
        case (state)
            B: g[1] = 1'b1;
            C: g[2] = 1'b1;
            D: g[3] = 1'b1;
        endcase
    end

endmodule
