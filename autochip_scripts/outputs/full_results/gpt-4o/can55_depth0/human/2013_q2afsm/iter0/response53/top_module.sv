module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    // Current state and next state variables
    reg [1:0] state, next_state;

    // State Table: Combinational logic to determine next state
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
                if (r[3])
                    next_state = D;
                else
                    next_state = A;
            end
            default: next_state = A;
        endcase
    end

    // State Flip-Flops: Synchronous logic to update current state
    always @(posedge clk) begin
        if (~resetn)
            state <= A;
        else
            state <= next_state;
    end

    // FSM Outputs
    always @(*) begin
        g = 3'b000;  // Default all grants to 0
        case (state)
            A: g = 3'b000;
            B: g = 3'b100;  // g1 = 1
            C: g = 3'b010;  // g2 = 1
            D: g = 3'b001;  // g3 = 1
        endcase
    end

endmodule
