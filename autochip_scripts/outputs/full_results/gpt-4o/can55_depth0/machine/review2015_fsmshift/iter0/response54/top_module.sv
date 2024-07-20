module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    // Define state codes
    localparam B0 = 3'b000;
    localparam B1 = 3'b001;
    localparam B2 = 3'b010;
    localparam B3 = 3'b011;
    localparam Done = 3'b100;

    // State register
    reg [2:0] state;
    reg [2:0] next_state;

    // State transition logic
    always @(*) begin
        case (state)
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = Done;
            Done: next_state = Done; // Stay in Done state
            default: next_state = Done; // Fault recovery
        endcase
    end

    // State register logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B0;
        end else begin
            state <= next_state;
        end
    end

    // Output logic for shift_ena
    always @(*) begin
        if (state == B0 || state == B1 || state == B2 || state == B3) begin
            shift_ena = 1'b1;
        end else begin
            shift_ena = 1'b0;
        end
    end

endmodule
