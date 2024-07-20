module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);
    reg [2:0] state, next_state;

    // State assignments
    localparam A = 3'b000;
    localparam B = 3'b001;
    localparam C = 3'b010;
    localparam D = 3'b011;

    // Outputs
    always @(state) begin
        case (state)
            B: g[1] = 1'b1;
            C: g[2] = 1'b1;
            D: g[3] = 1'b1;
            default: begin
                g[1] = 1'b0;
                g[2] = 1'b0;
                g[3] = 1'b0;
            end
        endcase
    end

    always @(posedge clk) begin
        if (~resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    always @(state, r) begin
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
