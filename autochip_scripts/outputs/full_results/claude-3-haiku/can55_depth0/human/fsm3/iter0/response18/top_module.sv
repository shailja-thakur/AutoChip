module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State declaration
    reg [1:0] state, next_state;
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    // Next state logic
    always @(*) begin
        case(state)
            A: begin
                if (in == 0) next_state = A;
                else next_state = B;
            end
            B: begin
                if (in == 0) next_state = C;
                else next_state = B;
            end
            C: begin
                if (in == 0) next_state = A;
                else next_state = D;
            end
            D: begin
                if (in == 0) next_state = C;
                else next_state = B;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        case(state)
            A, B, C: out = 0;
            D: out = 1;
        endcase
    end

    // State update logic
    always @(posedge clk, posedge areset) begin
        if (areset) state <= A;
        else state <= next_state;
    end

endmodule
