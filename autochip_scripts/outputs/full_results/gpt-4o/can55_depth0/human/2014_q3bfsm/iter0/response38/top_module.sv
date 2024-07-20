module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state, next_state;

    // State definitions
    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        case (state)
            S0: begin
                next_state = (x == 1'b0) ? S0 : S1;
                z = 1'b0;
            end
            S1: begin
                next_state = (x == 1'b0) ? S1 : S4;
                z = 1'b0;
            end
            S2: begin
                next_state = (x == 1'b0) ? S2 : S1;
                z = 1'b0;
            end
            S3: begin
                next_state = (x == 1'b0) ? S1 : S2;
                z = 1'b1;
            end
            S4: begin
                next_state = (x == 1'b0) ? S3 : S4;
                z = 1'b1;
            end
            default: begin
                next_state = S0;
                z = 1'b0;
            end
        endcase
    end

endmodule
