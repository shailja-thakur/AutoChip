module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the states
    localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

    // Declare the state register
    reg [2:0] state, next_state;

    // State transition logic
    always @(*)
    begin
        case (state)
            A: begin
                if (w == 0) next_state = B;
                else next_state = A;
            end
            B: begin
                if (w == 0) next_state = C;
                else next_state = D;
            end
            C: begin
                if (w == 0) next_state = E;
                else next_state = D;
            end
            D: begin
                if (w == 0) next_state = F;
                else next_state = A;
            end
            E: begin
                if (w == 0) next_state = E;
                else next_state = D;
            end
            F: begin
                if (w == 0) next_state = C;
                else next_state = D;
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*)
    begin
        case (state)
            E, F: z = 1;
            default: z = 0;
        endcase
    end

    // State register update
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
