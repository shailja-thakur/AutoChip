module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

// State transition logic equations
always @(*) begin
    case (state)
        4'b0001: next_state = in ? 4'b0010 : 4'b0001;
        4'b0010: next_state = in ? 4'b0100 : 4'b0010;
        4'b0100: next_state = in ? 4'b0001 : 4'b1000;
        4'b1000: next_state = in ? 4'b0010 : 4'b0100;
        default: next_state = 4'b0000;
    endcase
end

// Output logic equation
always @(state) begin
    case (state)
        4'b0001: out = 1'b0;
        4'b0010: out = 1'b0;
        4'b0100: out = 1'b0;
        4'b1000: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
