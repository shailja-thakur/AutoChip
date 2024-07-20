module top_module(
    input clk,
    input reset,
    output reg shift_ena,
    output reg [2:0] state
);

    // State declaration
    localparam B0 = 3'b000,
               B1 = 3'b001,
               B2 = 3'b010,
               B3 = 3'b011,
               Done = 3'b100;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B0;
        else begin
            case (state)
                B0: state <= B1;
                B1: state <= B2;
                B2: state <= B3;
                B3: state <= Done;
                Done: state <= Done;
                default: state <= Done;
            endcase
        end
    end

    // Combinational logic for shift_ena signal
    always @(*) begin
        case (state)
            B0, B1, B2, B3: shift_ena = 1;
            default: shift_ena = 0;
        endcase
    end

endmodule
