module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
    reg [3:1] state, next_state;
    reg [3:1] g_internal;

    // State parameter
    parameter A = 3'b001;
    parameter B = 3'b010;
    parameter C = 3'b011;
    parameter D = 3'b100;

    // Outputs
    assign g[1] = g_internal[1];
    assign g[2] = g_internal[2];
    assign g[3] = g_internal[3];

    always @(posedge clk) begin
        if (~resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    always @(state or r) begin
        case (state)
            A: begin
                if (r[1]) begin
                    next_state = B;
                    g_internal[1] <= 1;
                    g_internal[2] <= 0;
                    g_internal[3] <= 0;
                end else if (r[2]) begin
                    next_state = C;
                    g_internal[1] <= 0;
                    g_internal[2] <= 1;
                    g_internal[3] <= 0;
                end else if (r[3]) begin
                    next_state = D;
                    g_internal[1] <= 0;
                    g_internal[2] <= 0;
                    g_internal[3] <= 1;
                end else begin
                    next_state = A;
                    g_internal[1] <= 0;
                    g_internal[2] <= 0;
                    g_internal[3] <= 0;
                end
            end
            B: begin
                if (r[1]) begin
                    next_state = B;
                    g_internal[1] <= 1;
                    g_internal[2] <= 0;
                    g_internal[3] <= 0;
                end else begin
                    next_state = A;
                    g_internal[1] <= 0;
                    g_internal[2] <= 0;
                    g_internal[3] <= 0;
                end
            end
            C: begin
                if (r[2]) begin
                    next_state = C;
                    g_internal[1] <= 0;
                    g_internal[2] <= 1;
                    g_internal[3] <= 0;
                end else begin
                    next_state = A;
                    g_internal[1] <= 0;
                    g_internal[2] <= 0;
                    g_internal[3] <= 0;
                end
            end
            D: begin
                next_state = A;
                g_internal[1] <= 0;
                g_internal[2] <= 0;
                g_internal[3] <= 0;
            end
        endcase
    end
endmodule
