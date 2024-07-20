module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // State transition logic
    always @(in, state) begin
        case(state)
            4'b0001:   // State A
                if (in == 1'b0) begin
                    next_state <= 4'b0001;  // Next state A
                end else begin
                    next_state <= 4'b0010;  // Next state B
                end
            4'b0010:   // State B
                if (in == 1'b0) begin
                    next_state <= 4'b0100;  // Next state C
                end else begin
                    next_state <= 4'b0010;  // Next state B
                end
            4'b0100:   // State C
                if (in == 1'b0) begin
                    next_state <= 4'b0001;  // Next state A
                end else begin
                    next_state <= 4'b1000;  // Next state D
                end
            4'b1000:   // State D
                if (in == 1'b0) begin
                    next_state <= 4'b0100;  // Next state C
                end else begin
                    next_state <= 4'b0010;  // Next state B
                end
            default:
                next_state <= 4'bxxxx;  // Undefined state
        endcase
    end

    // Output logic
    always @(state) begin
        case(state)
            4'b1000:   // State D
                out <= 1'b1;   // Output 1
            default:
                out <= 1'b0;   // Output 0
        endcase
    end

endmodule
