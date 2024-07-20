module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State codes
    typedef enum reg [1:0] {A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11} state_t;
    state_t state, next_state;
    
    // State flip-flops
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // State table (combinational logic)
    always @(*) begin
        // Default assignments
        next_state = state;
        g = 3'b000;

        case(state)
            A: begin
                if (r[1]) begin
                    next_state = B;
                end else if (r[2]) begin
                    next_state = C;
                end else if (r[3]) begin
                    next_state = D;
                end
            end
            B: begin
                g[1] = 1;
                if (!r[1]) begin
                    next_state = A;
                end
            end
            C: begin
                g[2] = 1;
                if (!r[2]) begin
                    next_state = A;
                end
            end
            D: begin
                if (!r[3] && !r[1] && !r[2]) begin
                    next_state = A;
                end
            end
            default: begin
                next_state = A;
            end
        endcase
    end

endmodule
