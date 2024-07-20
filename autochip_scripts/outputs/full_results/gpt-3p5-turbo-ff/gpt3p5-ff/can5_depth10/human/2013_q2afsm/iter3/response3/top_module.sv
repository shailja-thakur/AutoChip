module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
    reg [3:1] state, next_state;

    // State parameter
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;

    // Outputs
    assign g[1] = (state == B && r[1]);
    assign g[2] = (state == C && r[2]);
    assign g[3] = (state == D && r[3]);

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
                if (r[1] && ~r[2] && ~r[3]) begin
                    next_state = B;
                end else if (~r[1] && r[2] && ~r[3]) begin
                    next_state = C;
                end else if (~r[1] && ~r[2] && ~r[3]) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (r[1] && ~r[2] && ~r[3]) begin
                    next_state = B;
                end else if (~r[1] && ~r[2] && ~r[3]) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            C: begin
                if (~r[1] && r[2] && ~r[3]) begin
                    next_state = C;
                end else if (~r[1] && ~r[2] && ~r[3]) begin
                    next_state = A;
                end else begin
                    next_state = C;
                end
            end
            D: begin
                next_state = A;
            end
        endcase
    end
endmodule
