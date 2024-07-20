module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    reg [2:0] next_state;

    always @(*) begin
        // Determine next state based on current state and input x
        case (y)
            3'b000: next_state = (x == 1'b0) ? 3'b000 : 3'b001;
            3'b001: next_state = (x == 1'b0) ? 3'b001 : 3'b100;
            3'b010: next_state = (x == 1'b0) ? 3'b010 : 3'b001;
            3'b011: next_state = (x == 1'b0) ? 3'b001 : 3'b010;
            3'b100: next_state = (x == 1'b0) ? 3'b011 : 3'b100;
            default: next_state = 3'b000;
        endcase
    end

    always @(posedge clk) begin
        // Update next state
        Y0 <= next_state[0];
    end

    always @(*) begin
        // Determine output z based on current state
        case (y)
            3'b000: z = 1'b0;
            3'b001: z = 1'b0;
            3'b010: z = 1'b0;
            3'b011: z = 1'b1;
            3'b100: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
