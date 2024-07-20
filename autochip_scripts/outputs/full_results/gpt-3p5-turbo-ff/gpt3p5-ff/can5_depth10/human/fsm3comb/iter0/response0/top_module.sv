module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

reg [1:0] next_state;

always @* begin
    case (state)
        2'b00: begin
            next_state = (in == 1) ? 2'b01 : 2'b00;
            out = 0;
        end
        2'b01: begin
            next_state = (in == 0) ? 2'b10 : 2'b01;
            out = 0;
        end
        2'b10: begin
            next_state = (in == 1) ? 2'b11 : 2'b00;
            out = 0;
        end
        2'b11: begin
            next_state = (in == 0) ? 2'b10 : 2'b01;
            out = 1;
        end
    endcase
end

endmodule
