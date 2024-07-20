module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
    reg [3:1] state, next_state;
    reg [3:1] g_reg;

    // State parameter
    parameter A = 3'b001;
    parameter B = 3'b010;
    parameter C = 3'b011;
    parameter D = 3'b100;

    // Outputs
    assign g = g_reg;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= A;
            g_reg <= 3'b000;
        end else begin
            state <= next_state;
            case (state)
                A: begin
                    if (r[1]) begin
                        g_reg <= 3'b001;
                        next_state = B;
                    end else if (r[2]) begin
                        g_reg <= 3'b010;
                        next_state = C;
                    end else if (r[3]) begin
                        g_reg <= 3'b100;
                        next_state = D;
                    end else begin
                        g_reg <= 3'b000;
                        next_state = A;
                    end
                end
                B: begin
                    if (r[1]) begin
                        g_reg <= 3'b001;
                        next_state = B;
                    end else begin
                        g_reg <= 3'b000;
                        next_state = A;
                    end
                end
                C: begin
                    if (r[2]) begin
                        g_reg <= 3'b010;
                        next_state = C;
                    end else begin
                        g_reg <= 3'b000;
                        next_state = A;
                    end
                end
                D: begin
                    g_reg <= 3'b100;
                    next_state = A;
                end
            endcase
        end
    end
endmodule
