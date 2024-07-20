module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // Define state codes
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State Flip-Flops
    always @(posedge clk) begin
        if (!resetn)
            current_state <= A; // Active-low reset
        else
            current_state <= next_state;
    end

    // State Table
    always @(*) begin
        case (current_state)
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
                if (!r[1] && !r[2])
                    next_state = A;
                // else retain in D
            end

            default: next_state = A;
        endcase
    end

    // Output Logic
    always @(*) begin
        case (current_state)
            A: g = 3'b000;
            B: g = 3'b001; // g1
            C: g = 3'b010; // g2
            D: g = 3'b100; // g3
            default: g = 3'b000;
        endcase
    end

endmodule
