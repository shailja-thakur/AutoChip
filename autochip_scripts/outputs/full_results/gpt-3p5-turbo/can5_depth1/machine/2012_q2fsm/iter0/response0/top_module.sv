module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000; // initial state is A
    else
        state <= next_state;
end

always @* begin
    case (state)
        3'b000: begin // state A
            if (w)
                next_state = 3'b001; // transition to B
            else
                next_state = 3'b000; // self-transition to A
        end
        3'b001: begin // state B
            if (w)
                next_state = 3'b010; // transition to C
            else
                next_state = 3'b011; // transition to D
        end
        3'b010: begin // state C
            if (w)
                next_state = 3'b110; // transition to E
            else
                next_state = 3'b011; // transition to D
        end
        3'b011: begin // state D
            if (w)
                next_state = 3'b111; // transition to F
            else
                next_state = 3'b000; // transition to A
        end
        3'b100: begin // state E
            next_state = 3'b100; // self-transition to E
        end
        3'b111: begin // state F
            next_state = 3'b010; // transition to C
        end
    endcase
end

assign z = (state == 3'b100 || state == 3'b111) ? 1'b1 : 1'b0;

endmodule
