module top_module(
    input clk,
    input reset,
    output shift_ena
);
    reg [2:0] state;
    reg [2:0] next_state;

    // state encoding
    localparam B0   = 3'b000,
               B1   = 3'b001,
               B2   = 3'b010,
               B3   = 3'b011,
               Done = 3'b100;

    // state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B0;
        end else begin
            state <= next_state;
        end
    end

    // next state logic
    always @(*) begin
        case (state)
            B0: next_state = B0 ? B1 : state;
            B1: next_state = B1 ? B2 : state;
            B2: next_state = B2 ? B3 : state;
            B3: next_state = B3 ? Done : state;
            default: next_state = Done;
        endcase
    end

    // shift_ena output logic
    assign shift_ena = (state == B0) | (state == B1) | (state == B2) | (state == B3);

endmodule
