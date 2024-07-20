module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    // State Encoding
    parameter A = 2'b00,
              B = 2'b01,
              C = 2'b10,
              D = 2'b11;

    // Next state and output logic
    always @(*) begin
        case (state)
            A: begin
                next_state = (in == 1'b0) ? A : B;
                out = 0;
            end
            B: begin
                next_state = (in == 1'b0) ? C : B;
                out = 0;
            end
            C: begin
                next_state = (in == 1'b0) ? A : D;
                out = 0;
            end
            D: begin
                next_state = (in == 1'b0) ? C : B;
                out = 1;
            end
            default: begin
                next_state = A; // Default case to handle any undefined state
                out = 0;
            end
        endcase
    end

endmodule
