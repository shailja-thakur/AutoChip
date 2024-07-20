module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state_wire,
    output out1_wire,
    output out2_wire);

    // Output declarations
    wire [9:0] next_state;
    reg [9:0] next_state_reg;
    wire out1;
    reg out1_reg;
    wire out2;
    reg out2_reg;

    // State transition logic
    always @(in, state) begin
        case(state)
            10'b0000000001: next_state_reg = 10'b0000000001; // S0 - 0 -> S0
            10'b0000000010: next_state_reg = 10'b0000000001; // S1 - 0 -> S0
            10'b0000000011: next_state_reg = 10'b0000000001; // S2 - 0 -> S0
            10'b0000000100: next_state_reg = 10'b0000000001; // S3 - 0 -> S0
            10'b0000000101: next_state_reg = 10'b0000000001; // S4 - 0 -> S0
            10'b0000000110: next_state_reg = 10'b0000001000; // S5 - 0 -> S8
            10'b0000000111: next_state_reg = 10'b0000000001; // S6 - 0 -> S0
            10'b0000001000: next_state_reg = 10'b0000000001; // S7 - 0 -> S0
            10'b0000001001: next_state_reg = 10'b0000000001; // S8 - 0 -> S0
            10'b0000001010: next_state_reg = 10'b0000000001; // S9 - 0 -> S0
            default: next_state_reg = 10'b0; // Default state
        endcase
    end

    always @(posedge clk) begin
        next_state <= next_state_reg;
    end

    // Output logic
    always @(state) begin
        case(state)
            10'b0000000110: out1_reg = 1'b1; // Output 1 logic
            default: out1_reg = 1'b0;
        endcase
    end

    always @(posedge clk) begin
        out1 <= out1_reg;
    end

    always @(state) begin
        case(state)
            10'b0000000111: out2_reg = 1'b1; // Output 2 logic
            default: out2_reg = 1'b0;
        endcase
    end

    always @(posedge clk) begin
        out2 <= out2_reg;
    end

    // Assigning outputs
    assign next_state_wire = next_state;
    assign out1_wire = out1;
    assign out2_wire = out2;

endmodule
