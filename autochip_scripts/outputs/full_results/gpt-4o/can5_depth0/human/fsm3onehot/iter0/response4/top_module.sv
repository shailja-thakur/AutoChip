module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // Output logic
    assign out = state[3];

    // State transition logic
    always @(*) begin
        case (state)
            4'b0001:  // A
                if (in)
                    next_state = 4'b0010;  // B
                else
                    next_state = 4'b0001;  // A
            4'b0010:  // B
                if (in)
                    next_state = 4'b0010;  // B
                else
                    next_state = 4'b0100;  // C
            4'b0100:  // C
                if (in)
                    next_state = 4'b1000;  // D
                else
                    next_state = 4'b0001;  // A
            4'b1000:  // D
                if (in)
                    next_state = 4'b0010;  // B
                else
                    next_state = 4'b0100;  // C
            default: 
                next_state = 4'b0001;  // Default to state A
        endcase
    end

endmodule
