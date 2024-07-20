module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state;

    // State encoding
    localparam B0 = 3'b000;
    localparam B1 = 3'b001;
    localparam B2 = 3'b010;
    localparam B3 = 3'b011;
    localparam Done = 3'b100;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B0; // Reset state is B0
        end else begin
            case (state)
                B0: state <= B1;
                B1: state <= B2;
                B2: state <= B3;
                B3: state <= Done;
                default: state <= Done; // In case of any invalid state, go to Done
            endcase
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            B0, B1, B2, B3: shift_ena = 1;
            default: shift_ena = 0; // Done state
        endcase
    end
    
endmodule
