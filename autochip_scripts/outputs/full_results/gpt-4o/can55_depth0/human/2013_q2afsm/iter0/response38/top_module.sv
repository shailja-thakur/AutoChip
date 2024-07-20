module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State Encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t state, next_state;
    
    // State Register (Sequential)
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // State Transition Table (Combinatorial)
    always_comb begin
        next_state = state; // default to remain in current state
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
            default: next_state = A; // Default state
        endcase
    end

    // Output Logic
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            g <= 3'b000;
        else begin
            case (state)
                A: g <= 3'b000;
                B: g <= 3'b001; // g1 = 1
                C: g <= 3'b010; // g2 = 1
                D: g <= 3'b100; // g3 = 1
                default: g <= 3'b000;
            endcase
        end
    end

endmodule
