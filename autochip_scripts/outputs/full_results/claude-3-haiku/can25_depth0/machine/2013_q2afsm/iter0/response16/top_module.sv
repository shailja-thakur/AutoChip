module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state, next;
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk) begin
    if (!resetn) begin
        state <= A;
    end else begin
        state <= next;
    end
end

always @(*) begin
    case (state)
        A: begin
            if (r[0]) begin
                next = B;
            end else if (r[1]) begin
                next = C;
            end else if (r[2]) begin
                next = D;
            end else begin
                next = A;
            end
        end
        B: begin
            if (r[0]) begin
                next = B;
            end else begin
                next = A;
            end
        end
        C: begin
            if (r[1]) begin
                next = C;
            end else begin
                next = A;
            end
        end
        D: begin
            if (r[2]) begin
                next = D;
            end else begin
                next = A;
            end
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
