module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;
    
    reg [1:0] state, next_state;

    // State flip-flops (state register)
    always @(posedge clk) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // State table (next state logic)
    always @(*) begin
        case (state)
            A: begin
                if (r[1])
                    next_state = B;
                else if (r[2])
                    next_state = C;
                else if (r[3])
                    next_state = D;
                else
                    next_state = A;
            end
            B: begin
                if (r[1])
                    next_state = B;
                else
                    next_state = A;
            end
            C: begin
                if (r[2])
                    next_state = C;
                else
                    next_state = A;
            end
            D: begin
                if (!r[1] && !r[2] && !r[3])
                    next_state = A;
                else
                    next_state = D; // Stay in D if any request is asserted
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        // Default outputs
        g = 3'b000;
        case (state)
            B: g[1] = 1;
            C: g[2] = 1;
            D: g[3] = 1;
        endcase
    end

endmodule
