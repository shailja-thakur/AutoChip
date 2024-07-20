module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State encoding
    reg [2:0] state, next_state;
    localparam A = 3'b000,
               B = 3'b001,
               C = 3'b010,
               D = 3'b011,
               E = 3'b100;

    // Output logic
    always @(*) begin
        case (state)
            D: z = 1;
            E: z = 1;
            default: z = 0;
        endcase
    end

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (x == 1'b0) ? A : B;
            B: next_state = (x == 1'b0) ? B : E;
            C: next_state = (x == 1'b0) ? C : B;
            D: next_state = (x == 1'b0) ? B : C;
            E: next_state = (x == 1'b0) ? D : E;
            default: next_state = A;
        endcase
    end

    // State update
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
endmodule
