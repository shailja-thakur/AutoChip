module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State parameters
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11, E = 3'b100, F = 3'b101;

    // State register
    reg [2:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (w) next_state = A;
                else next_state = B;
            end
            B: begin
                if (w) next_state = D;
                else next_state = C;
            end
            C: begin
                if (w) next_state = D;
                else next_state = E;
            end
            D: begin
                if (w) next_state = A;
                else next_state = F;
            end
            E: begin
                if (w) next_state = D;
                else next_state = E;
            end
            F: begin
                if (w) next_state = D;
                else next_state = C;
            end
            default: next_state = A;
        endcase
    end

    // State register update
    always @(posedge clk) begin
        if (reset) state <= A;
        else state <= next_state;
    end

    // Output logic
    always @(*) begin
        z = (state == E) || (state == F);
    end

endmodule
