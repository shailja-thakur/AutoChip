module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always_comb begin
    case (state)
        2'b00: begin // State A
            if (in) begin
                next_state = 2'b01; // Next state is B
            end else begin
                next_state = 2'b00; // Stay in A
            end
            out = 1'b0; // Output is 0
        end
        2'b01: begin // State B
            if (in) begin
                next_state = 2'b01; // Stay in B
            end else begin
                next_state = 2'b10; // Next state is C
            end
            out = 1'b0; // Output is 0
        end
        2'b10: begin // State C
            if (in) begin
                next_state = 2'b11; // Next state is D
            end else begin
                next_state = 2'b00; // Next state is A
            end
            out = 1'b0; // Output is 0
        end
        2'b11: begin // State D
            if (in) begin
                next_state = 2'b01; // Next state is B
            end else begin
                next_state = 2'b10; // Next state is C
            end
            out = 1'b1; // Output is 1
        end
        default: begin
            next_state = 2'b00; // Default to state A
            out = 1'b0; // Output is 0
        end
    endcase
end

endmodule
