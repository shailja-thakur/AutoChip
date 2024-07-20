module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    reg [3:1] state, next_state;
    reg [3:1] g_reg;

    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= A;
            g_reg <= 3'b000;
        end else begin
            state <= next_state;
            g_reg <= (g_reg & r) | (g & ~r);
        end
    end

    always @(state or r) begin
        case (state)
            A: begin
                if (r[1]) begin
                    next_state = B;
                end else if (r[2]) begin
                    next_state = C;
                end else if (r[3]) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (r[1]) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            C: begin
                if (r[2]) begin
                    next_state = C;
                end else begin
                    next_state = A;
                end
            end
            D: begin
                if (r[1] || r[2] || r[3]) begin
                    next_state = A;
                end else begin
                    next_state = D;
                end
            end
        endcase
    end

    assign g = g_reg;

endmodule
