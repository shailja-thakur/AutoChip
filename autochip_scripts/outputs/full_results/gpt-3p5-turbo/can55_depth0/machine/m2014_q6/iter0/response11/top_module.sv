module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State enumeration
    parameter [2:0] A = 3'b000;
    parameter [2:0] B = 3'b001;
    parameter [2:0] C = 3'b010;
    parameter [2:0] D = 3'b011;
    parameter [2:0] E = 3'b100;
    parameter [2:0] F = 3'b101;

    // State register and next state logic
    reg [2:0] state, next_state;
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // State transition logic
    always @(state, w) begin
        case (state)
            A: if (w) next_state = A; else next_state = B;
            B: if (w) next_state = D; else next_state = C;
            C: if (w) next_state = D; else next_state = E;
            D: if (w) next_state = A; else next_state = F;
            E: if (w) next_state = D; else next_state = E;
            F: if (w) next_state = D; else next_state = C;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(state) begin
        case (state)
            E, F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
