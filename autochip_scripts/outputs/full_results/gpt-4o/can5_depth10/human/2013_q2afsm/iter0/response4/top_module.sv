module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);
    // State declaration
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;

    // State flip-flops (sequential logic)
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // State Table (combinational logic)
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
                next_state = A; // Assuming state D automatically goes to A
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            A: g = 3'b000;
            B: g = 3'b001; // g1 is granted
            C: g = 3'b010; // g2 is granted
            D: g = 3'b100; // g3 is granted
            default: g = 3'b000;
        endcase
    end

endmodule
