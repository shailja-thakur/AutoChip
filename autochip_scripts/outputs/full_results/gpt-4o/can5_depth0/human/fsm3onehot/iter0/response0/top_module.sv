module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    // State transition logic
    always @(*) begin
        case (state)
            4'b0001: next_state = (in == 1'b0) ? 4'b0001 : 4'b0010; // A -> A or B
            4'b0010: next_state = (in == 1'b0) ? 4'b0100 : 4'b0010; // B -> C or B
            4'b0100: next_state = (in == 1'b0) ? 4'b0001 : 4'b1000; // C -> A or D
            4'b1000: next_state = (in == 1'b0) ? 4'b0100 : 4'b0010; // D -> C or B
            default: next_state = 4'b0001; // Default to state A
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            4'b1000: out = 1'b1; // D => output is 1
            default: out = 1'b0; // All other states => output is 0
        endcase
    end

endmodule
