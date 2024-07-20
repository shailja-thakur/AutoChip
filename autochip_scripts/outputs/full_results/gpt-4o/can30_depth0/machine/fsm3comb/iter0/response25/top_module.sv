module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

    // State encoding
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;

    // Temporary signal for next state logic
    reg [1:0] temp_next_state;

    always @(*) begin
        case (state)
            A: begin
                if (in)
                    temp_next_state = B;
                else
                    temp_next_state = A;
            end
            B: begin
                if (in)
                    temp_next_state = B;
                else
                    temp_next_state = C;
            end
            C: begin
                if (in)
                    temp_next_state = D;
                else
                    temp_next_state = A;
            end
            D: begin
                if (in)
                    temp_next_state = B;
                else
                    temp_next_state = C;
            end
            default: temp_next_state = A;
        endcase

        next_state = temp_next_state;
    end

    // Output logic
    assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
