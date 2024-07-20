module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);
    reg [3:1] state, next_state;

    // State parameter
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;

    // Outputs
    always @(state) begin
        case (state)
            A: begin
                g[1] = 0;
                g[2] = 0;
                g[3] = 0;
            end
            B: begin
                g[1] = 1;
                g[2] = 0;
                g[3] = 0;
            end
            C: begin
                g[1] = 0;
                g[2] = 1;
                g[3] = 0;
            end
            D: begin
                g[1] = 0;
                g[2] = 0;
                g[3] = 1;
            end
        endcase
    end

    always @(posedge clk or negedge resetn) begin
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
                next_state = A;
            end
        endcase
    end
endmodule
