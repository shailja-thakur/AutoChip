module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

always @(*) begin
    case(state)
        4'b0001: begin // State A
            if (in)
                next_state = 4'b0010; // Next state is B
            else
                next_state = 4'b0001; // Next state is A

            out = 1'b0; // Output is 0
        end

        4'b0010: begin // State B
            if (in)
                next_state = 4'b0010; // Next state is B
            else
                next_state = 4'b0100; // Next state is C

            out = 1'b0; // Output is 0
        end

        4'b0100: begin // State C
            if (in)
                next_state = 4'b0001; // Next state is A
            else
                next_state = 4'b1000; // Next state is D

            out = 1'b0; // Output is 0
        end

        4'b1000: begin // State D
            if (in)
                next_state = 4'b0100; // Next state is C
            else
                next_state = 4'b0010; // Next state is B

            out = 1'b1; // Output is 1
        end
    endcase
end

endmodule
