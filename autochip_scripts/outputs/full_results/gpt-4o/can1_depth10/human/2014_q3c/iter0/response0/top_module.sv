module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    reg [2:0] state;
    reg [2:0] next_state;

    // State transition logic
    always @(*) begin
        case (state)
            3'b000: next_state = x ? 3'b001 : 3'b000;
            3'b001: next_state = x ? 3'b100 : 3'b001;
            3'b010: next_state = x ? 3'b001 : 3'b010;
            3'b011: next_state = x ? 3'b010 : 3'b001;
            3'b100: next_state = x ? 3'b100 : 3'b011;
            default: next_state = 3'b000;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            3'b000: z = 1'b0;
            3'b001: z = 1'b0;
            3'b010: z = 1'b0;
            3'b011: z = 1'b1;
            3'b100: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

    // State update on clock edge
    always @(posedge clk) begin
        state <= next_state;
    end

    // Y0 output logic (assuming Y0 represents the LSB of the next state)
    always @(*) begin
        Y0 = next_state[0];
    end

endmodule
