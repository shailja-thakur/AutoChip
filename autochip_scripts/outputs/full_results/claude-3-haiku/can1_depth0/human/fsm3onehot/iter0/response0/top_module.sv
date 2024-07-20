module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    always @(*) begin
        case (state)
            4'b0001: next_state = in ? 4'b0010 : 4'b0001;
            4'b0010: next_state = in ? 4'b0010 : 4'b0100;
            4'b0100: next_state = in ? 4'b1000 : 4'b0001;
            4'b1000: next_state = in ? 4'b0010 : 4'b0100;
            default: next_state = 4'b0001;
        endcase
    end

    assign out = (state == 4'b1000);

endmodule
