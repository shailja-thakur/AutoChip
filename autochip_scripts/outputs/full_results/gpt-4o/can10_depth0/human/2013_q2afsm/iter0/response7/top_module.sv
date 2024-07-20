module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011
    } state_t;

    state_t state, next_state;

    // State transition (State Table)
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
                next_state = A;
            end
            default: next_state = A;
        endcase
    end

    // State flip-flops (sequential logic)
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic (depending on the state)
    always @(*) begin
        case (state)
            A: g = 3'b000;
            B: g = 3'b001; // Grant to device 1
            C: g = 3'b010; // Grant to device 2
            D: g = 3'b100; // Grant to device 3
            default: g = 3'b000;
        endcase
    end

endmodule
