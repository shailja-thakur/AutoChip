module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    // State encoding
    parameter A = 3'b000,
              B = 3'b001,
              C = 3'b010,
              D = 3'b011,
              E = 3'b100;

    // Internal state variable
    reg [2:0] state, next_state;

    // State transition logic
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
            A: if (x) next_state = B; else next_state = A;
            B: if (x) next_state = E; else next_state = B;
            C: if (x) next_state = B; else next_state = C;
            D: if (x) next_state = C; else next_state = B;
            E: if (x) next_state = E; else next_state = D;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        if (state == D || state == E) begin
            z = 1'b1;
        end else begin
            z = 1'b0;
        end
    end

endmodule
