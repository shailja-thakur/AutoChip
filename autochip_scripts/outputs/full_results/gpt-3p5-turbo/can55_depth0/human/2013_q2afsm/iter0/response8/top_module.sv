module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [3:1] state, next_state;

parameter A = 1'b0;
parameter B = 1'b1;
parameter C = 1'b2;
parameter D = 1'b3;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @* begin
    next_state = state;
    g = 3'b0;

    case (state)
        A: begin
            if (r[1] & !r[2] & !r[3]) begin
                next_state = A;
            end else if (r[1] & !r[2]) begin
                next_state = B;
                g[1] = 1'b1;
            end else if (!r[1] & r[2]) begin
                next_state = C;
                g[2] = 1'b1;
            end else if (!r[1] & !r[2] & !r[3]) begin
                next_state = D;
            end
        end
        B: begin
            if (r[1]) begin
                next_state = B;
                g[1] = 1'b1;
            end else begin
                next_state = A;
            end
        end
        C: begin
            if (r[2]) begin
                next_state = C;
                g[2] = 1'b1;
            end else begin
                next_state = A;
            end
        end
        D: begin
            next_state = A;
        end
    endcase
end

endmodule
