module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

always @ (state) begin
    case (state)
        4'b0001: if (in) begin next_state = 4'b0010; out = 1; end else begin next_state = 4'b0001; out = 0; end
        4'b0010: if (in) begin next_state = 4'b0010; out = 0; end else begin next_state = 4'b0100; out = 0; end
        4'b0100: if (in) begin next_state = 4'b0001; out = 0; end else begin next_state = 4'b1000; out = 0; end
        4'b1000: if (in) begin next_state = 4'b0100; out = 1; end else begin next_state = 4'b0010; out = 0; end
        default: next_state = 4'bxxxx; out = 0;
    endcase
end

endmodule
