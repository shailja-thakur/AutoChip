module top_module(
    input clk,
    input reset,
    output reg shift_ena,
    output [2:0] state
);

    // State encoding
    localparam B0   = 3'b000,
               B1   = 3'b001,
               B2   = 3'b010,
               B3   = 3'b011,
               DONE = 3'b100;

    reg [2:0] current_state, next_state;

    // State shift_ena logic
    always @(*) begin
        case (current_state)
            B0, B1, B2, B3: shift_ena = 1;
            default: shift_ena = 0;
        endcase
    end

    // State transition logic
    always @(*) begin
        case (current_state)
            B0:   next_state = B1;
            B1:   next_state = B2;
            B2:   next_state = B3;
            B3:   next_state = DONE;
            default: next_state = DONE;
        endcase
    end

    // State register logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= B0;
        end else begin
            current_state <= next_state;
        end
    end

    // Output current state
    assign state = current_state;

endmodule
