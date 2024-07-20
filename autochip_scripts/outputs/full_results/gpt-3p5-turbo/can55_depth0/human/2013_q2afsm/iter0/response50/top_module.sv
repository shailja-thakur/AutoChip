module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [3:1] state, next_state;
reg [3:1] g;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: begin
            if (r[1]) begin
                next_state = B;
                g[1] = 1;
                g[2] = 0;
                g[3] = 0;
            end else if (r[2]) begin
                next_state = C;
                g[1] = 0;
                g[2] = 1;
                g[3] = 0;
            end else if (r[3]) begin
                next_state = D;
                g[1] = 0;
                g[2] = 0;
                g[3] = 1;
            end else begin
                next_state = A;
                g[1] = 0;
                g[2] = 0;
                g[3] = 0;
            end
        end
        B: begin
            if (r[1]) begin
                next_state = B;
                g[1] = 1;
                g[2] = 0;
                g[3] = 0;
            end else begin
                next_state = A;
                g[1] = 0;
                g[2] = 0;
                g[3] = 0;
            end
        end
        C: begin
            if (r[2]) begin
                next_state = C;
                g[1] = 0;
                g[2] = 1;
                g[3] = 0;
            end else begin
                next_state = A;
                g[1] = 0;
                g[2] = 0;
                g[3] = 0;
            end
        end
        D: begin
            if (r[1] || r[2]) begin
                next_state = D;
                g[1] = 0;
                g[2] = 0;
                g[3] = 0;
            end else begin
                next_state = A;
                g[1] = 0;
                g[2] = 0;
                g[3] = 0;
            end
        end
        default: begin
            next_state = A;
            g[1] = 0;
            g[2] = 0;
            g[3] = 0;
        end
    endcase
end

endmodule
