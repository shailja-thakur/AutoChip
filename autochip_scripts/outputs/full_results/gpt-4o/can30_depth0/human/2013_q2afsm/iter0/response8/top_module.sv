module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // state encoding
    typedef enum logic [1:0] {A=2'd0, B=2'd1, C=2'd2, D=2'd3} state_t;
    state_t state, next_state;
    
    // state transition
    always_ff @(posedge clk or negedge resetn) begin
        if (~resetn)
            state <= A;
        else
            state <= next_state;
    end

    // next state logic
    always_comb begin
        next_state = state; // default state assignment
        case (state)
            A: begin
                if (r[1])
                    next_state = B;
                else if (r[2])
                    next_state = C;
                else if (r[3])
                    next_state = D;
            end
            B: begin
                if (!r[1])
                    next_state = A;
            end
            C: begin
                if (!r[2])
                    next_state = A;
            end
            D: begin
                if (!r[3])
                    next_state = A;
            end
            default: next_state = A;
        endcase
    end

    // output logic
    always_ff @(posedge clk or negedge resetn) begin
        if (~resetn)
            g <= 3'd0;
        else begin
            g = 3'd0; // default to no grant
            case (state)
                B: g[1] = 1'b1;
                C: g[2] = 1'b1;
                D: g[3] = 1'b1;
                default: g = 3'd0;
            endcase
        end
    end

endmodule
