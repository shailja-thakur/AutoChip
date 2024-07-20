module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

    reg [2:0] state;
    reg [2:0] next_state;

    always @(posedge clk, posedge reset) begin
        if (reset)
            state <= 3'b000;
        else
            state <= next_state;
    end

    always @(state, w) begin
        case (state)
            3'b010: if (w) next_state = 3'b100;
                    else next_state = 3'b001;
            3'b011: if (w) next_state = 3'b101;
                    else next_state = 3'b001;
            3'b100: if (w) next_state = 3'b111;
                    else next_state = 3'b000;
            3'b101: if (w) next_state = 3'b010;
                    else next_state = 3'b010;
            3'b110: if (w) next_state = 3'b110;
                    else next_state = 3'b011;
            3'b111: if (w) next_state = 3'b011;
                    else next_state = 3'b011;
            default: if (w) next_state = 3'b011;
                     else next_state = 3'b001;
        endcase
    end

    always @(state) begin
        if (state == 3'b110 || state == 3'b111)
            z = 1;
        else
            z = 0;
    end

endmodule
