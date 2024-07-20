module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    // Output logic
    always @(*) begin
        case (state)
            4'b0001: out = 0; // State A
            4'b0010: out = 0; // State B
            4'b0100: out = 0; // State C
            4'b1000: out = 1; // State D
            default: out = 0; // Default case
        endcase
    end

    // Next state logic
    always @(*) begin
        case (state)
            4'b0001: next_state = in ? 4'b0010 : 4'b0001; // State A
            4'b0010: next_state = in ? 4'b0010 : 4'b0100; // State B
            4'b0100: next_state = in ? 4'b1000 : 4'b0001; // State C
            4'b1000: next_state = in ? 4'b0010 : 4'b0100; // State D
            default: next_state = 4'b0001; // Default case
        endcase
    end
endmodule
