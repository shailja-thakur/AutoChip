module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [3:1] state;
reg [3:1] next_state;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @* begin
    next_state = state;
    g = 3'b000;

    case (state)
        A: begin
            if (r[1] && ~r[2] && ~r[3]) begin
                next_state = A;
            end else if (r[1]) begin
                next_state = B;
            end else if (~r[1] && r[2]) begin
                next_state = C;
            end else if (~r[1] && ~r[2] && ~r[3]) begin
                next_state = D;
            end
        end
        B: begin
            if (r[1]) begin
                g[1] = 1;
                next_state = B;
            end else if (~r[1] && r[3]) begin
                g[3] = 1;
                next_state = A;
            end
        end
        C: begin
            if (r[2]) begin
                g[2] = 1;
                next_state = C;
            end else if (~r[2] && r[3]) begin
                g[3] = 1;
                next_state = A;
            end
        end
        D: begin
            if (~r[1] && ~r[2] && ~r[3]) begin
                next_state = D;
            end else if (r[1]) begin
                g[1] = 1;
                next_state = B;
            end else if (~r[1] && r[2]) begin
                g[2] = 1;
                next_state = C;
            end else if (~r[1] && ~r[2] && r[3]) begin
                g[3] = 1;
                next_state = A;
            end
        end
    endcase
end

endmodule
