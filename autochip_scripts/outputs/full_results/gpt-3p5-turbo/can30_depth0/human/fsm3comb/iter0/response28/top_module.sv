module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output wire out
);

always @(*) begin
    case(state)
        2'b00: begin // state A
            if (in == 1'b0) begin
                next_state = 2'b00; // next state is A
                out = 1'b0;
            end
            else if (in == 1'b1) begin
                next_state = 2'b01; // next state is B
                out = 1'b0;
            end
        end
        2'b01: begin // state B
            if (in == 1'b0) begin
                next_state = 2'b10; // next state is C
                out = 1'b0;
            end
            else if (in == 1'b1) begin
                next_state = 2'b01; // next state is B
                out = 1'b0;
            end
        end
        2'b10: begin // state C
            if (in == 1'b0) begin
                next_state = 2'b00; // next state is A
                out = 1'b0;
            end
            else if (in == 1'b1) begin
                next_state = 2'b11; // next state is D
                out = 1'b0;
            end
        end
        2'b11: begin // state D
            if (in == 1'b0) begin
                next_state = 2'b10; // next state is C
                out = 1'b1;
            end
            else if (in == 1'b1) begin
                next_state = 2'b01; // next state is B
                out = 1'b0;
            end
        end
        default: begin
            next_state = 2'b00;
            out = 1'b0;
        end
    endcase
end

endmodule
