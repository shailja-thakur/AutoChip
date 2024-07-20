module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define states using localparam
    localparam A = 3'b000,
               B = 3'b001,
               C = 3'b010,
               S10 = 3'b011,
               S11 = 3'b100,
               S20 = 3'b101,
               S21 = 3'b110,
               S22 = 3'b111;

    reg [2:0] state, next_state;

    // Synchronous state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: if (s)
                next_state = B;
               else
                next_state = A;
            B: if (w)
                next_state = S11;
               else
                next_state = S10;
            C: if (w)
                next_state = S11;
               else
                next_state = S10;
            S10: if (w)
                 next_state = S21;
                else
                 next_state = S20;
            S11: if (w)
                 next_state = S22;
                else
                 next_state = S21;
            S20: next_state = B;
            S21: if (w)
                 next_state = C;
                else
                 next_state = B;
            S22: if (w)
                 next_state = B;
                else
                 next_state = C;
            default: next_state = A;
        endcase
    end

    // Output logic
    // Assuming the output 'z' needs to be set based on a specific condition
    // Here, I'm assuming 'z = 1' when in state S10, else 'z = 0'
    always @(state) begin
        case (state)
            S10: z = 1;
            default: z = 0;
        endcase
    end

endmodule
