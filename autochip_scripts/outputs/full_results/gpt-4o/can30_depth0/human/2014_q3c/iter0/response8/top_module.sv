module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    // State assignment encoding
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    reg [2:0] state, next_state;

    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = (x == 1'b0) ? S0 : S1;
            S1: next_state = (x == 1'b0) ? S1 : S4;
            S2: next_state = (x == 1'b0) ? S2 : S1;
            S3: next_state = (x == 1'b0) ? S1 : S2;
            S4: next_state = (x == 1'b0) ? S3 : S4;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            S0, S1, S2: z = 1'b0;
            S3, S4: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

    // State register
    always @(posedge clk) begin
        state <= next_state;
    end

    // Assign the output Y0 from the next state
    always @(*) begin
        Y0 = next_state[0];
    end

endmodule
