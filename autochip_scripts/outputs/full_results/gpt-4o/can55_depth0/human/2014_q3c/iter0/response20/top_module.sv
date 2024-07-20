module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    reg [2:0] state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (y)
            3'b000: next_state = x ? 3'b001 : 3'b000;
            3'b001: next_state = x ? 3'b100 : 3'b001;
            3'b010: next_state = x ? 3'b001 : 3'b010;
            3'b011: next_state = x ? 3'b010 : 3'b001;
            3'b100: next_state = x ? 3'b100 : 3'b011;
            default: next_state = 3'b000;
        endcase
    end

    // Output logic (combinational)
    always @(*) begin
        case (y)
            3'b000, 3'b001, 3'b010: z = 0;
            3'b011, 3'b100: z = 1;
            default: z = 0;
        endcase
    end

    // State register (sequential)
    always @(posedge clk) begin
        state <= next_state;
    end

    // Assign the output Y0 to the least significant bit of the state
    always @(posedge clk) begin
        Y0 <= next_state[0];
    end

endmodule
