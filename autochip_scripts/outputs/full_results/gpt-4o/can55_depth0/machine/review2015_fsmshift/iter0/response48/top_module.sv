module top_module(
    input clk,
    input reset,
    output shift_ena
);

    reg [2:0] state, next_state;

    // State encoding
    localparam B0 = 3'b000;
    localparam B1 = 3'b001;
    localparam B2 = 3'b010;
    localparam B3 = 3'b011;
    localparam Done = 3'b100;

    // State transition logic
    always @(*) begin
        case (state)
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = Done;
            default: next_state = Done;
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B0;
        else
            state <= next_state;
    end

    // Output logic
    assign shift_ena = (state == B0) || (state == B1) || (state == B2) || (state == B3);

endmodule
