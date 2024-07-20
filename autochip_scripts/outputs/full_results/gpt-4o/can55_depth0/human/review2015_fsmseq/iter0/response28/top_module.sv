module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [2:0] state, next_state;

    // State encoding
    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100; // End state where sequence 1101 is detected

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = (data) ? S1 : S0;
            S1: next_state = (data) ? S2 : S0;
            S2: next_state = (data) ? S2 : S3;
            S3: next_state = (data) ? S4 : S0;
            S4: next_state = S4; // Lock in the final state
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 1'b0;
        end else if (state == S4) begin
            start_shifting <= 1'b1;
        end
    end

endmodule
