module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the states
    localparam [2:0] A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

    // Define the state register
    reg [2:0] current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: begin
                if (w == 1'b0) next_state = B;
                else next_state = A;
            end
            B: begin
                if (w == 1'b1) next_state = D;
                else next_state = C;
            end
            C: begin
                if (w == 1'b1) next_state = D;
                else next_state = E;
            end
            D: begin
                if (w == 1'b1) next_state = A;
                else next_state = F;
            end
            E: begin
                if (w == 1'b1) next_state = D;
                else next_state = E;
            end
            F: begin
                if (w == 1'b1) next_state = D;
                else next_state = C;
            end
            default: next_state = A;
        endcase
    end

    // State register update
    always @(posedge clk) begin
        if (reset) current_state <= A;
        else current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (current_state == E || current_state == F) z = 1'b1;
        else z = 1'b0;
    end

endmodule
