module top_module(
    input clk,
    input reset,
    output reg shift_ena
);
    reg [2:0] state;
    reg [2:0] next_state;

    // State declaration
    localparam B0   = 3'b000,
               B1   = 3'b001,
               B2   = 3'b010,
               B3   = 3'b011,
               Done = 3'b100;

    // State transition logic (combinational logic)
    always @(*) begin
        case(state)
            B0:   next_state = B1;
            B1:   next_state = B2;
            B2:   next_state = B3;
            B3:   next_state = Done;
            Done: next_state = Done;
            default: next_state = Done;
        endcase
    end

    // State flip-flops (sequential logic)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B0;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case(state)
            B0, B1, B2, B3: shift_ena = 1;
            Done:           shift_ena = 0;
            default:        shift_ena = 0;
        endcase
    end

endmodule
