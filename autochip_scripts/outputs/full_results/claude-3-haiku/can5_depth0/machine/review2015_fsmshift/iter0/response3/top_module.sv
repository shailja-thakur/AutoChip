module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] state;
    localparam B0 = 3'b000,
              B1 = 3'b001,
              B2 = 3'b010,
              B3 = 3'b011,
              Done = 3'b100;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B0;
        end
        else begin
            case (state)
                B0: state <= B1;
                B1: state <= B2;
                B2: state <= B3;
                B3: state <= Done;
                Done: state <= state;
                default: state <= B0;
            endcase
        end
    end

    always @(*) begin
        case (state)
            B0, B1, B2, B3: shift_ena = 1'b1;
            default: shift_ena = 1'b0;
        endcase
    end

endmodule
