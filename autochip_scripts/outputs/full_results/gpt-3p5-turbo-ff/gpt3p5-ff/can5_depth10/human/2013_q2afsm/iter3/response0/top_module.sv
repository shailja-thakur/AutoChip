module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
    reg [3:1] state, next_state;

    // State parameter
    parameter A = 3'b001;
    parameter B = 3'b010;
    parameter C = 3'b011;
    parameter D = 3'b100;

    // Outputs
    assign g[1] = (state == B);
    assign g[2] = (state == C);
    assign g[3] = (state == D);

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
                if (r[1] && !r[2] && !r[3]) begin
                    next_state = B;
                end else if (!r[1] && r[2] && !r[3]) begin
                    next_state = C;
                end else if (!r[1] && !r[2] && r[3]) begin
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
                next_state = A;
            end
        endcase
    end
endmodule
